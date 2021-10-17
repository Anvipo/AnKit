//
//  ImageProvider.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import Combine
import UIKit

/// Provider for images.
public final class ImageProvider {
	private let imageContent: ImageContent
	private let imageProcessingQueue: DispatchQueue
	private let mainQueue: DispatchQueue

	private var state: State
	private var cancellables: Set<AnyCancellable>
	private var onCompletes: [OnComplete]

	/// Initializes provider with specified parameters.
	/// - Parameters:
	///   - imageContent: Image content.
	///   - imageProcessingQueue: Image processing queue.
	///   - mainQueue: Main queue.
	public init(
		imageContent: ImageContent,
		imageProcessingQueue: DispatchQueue = .global(qos: .userInitiated),
		mainQueue: DispatchQueue = .main
	) {
		self.imageContent = imageContent
		self.imageProcessingQueue = imageProcessingQueue
		self.mainQueue = mainQueue

		cancellables = []
		state = .initial
		onCompletes = []
	}
}

public extension ImageProvider {
	/// Setups image in specified `imageView`.
	/// - Parameters:
	///   - imageView: Image view, which will contain image.
	///   - shouldSetImageToImageView: Should set image to image view or not.
	func setupImage(
		in imageView: UIImageView,
		shouldSetImageToImageView: @escaping () -> Bool = { true }
	) throws {
		switch imageContent {
		case let .localImage(uiImageProvider):
			imageView.image = uiImageProvider.uiImage

		case .remoteURL:
			let shouldShimmer = state != .downloaded

			if shouldShimmer {
				imageView.showShimmer()
			}

			requestImage { [weak imageView, weak self] result in
				guard let self = self,
					  let imageView = imageView,
					  shouldSetImageToImageView()
				else {
					return
				}

				self.set(newImage: result.success, to: imageView, shouldHideShimmer: shouldShimmer)
			}
		}
	}
}

extension ImageProvider {
	typealias Result = Swift.Result<UIImage, ProcessingError>
	typealias OnComplete = (Result) -> Void

	func prefetch() {
		switch imageContent {
		case let .remoteURL(imageRemoteURLProvider, imageDownloader, _):
			if state == .downloading || state == .downloaded {
				return
			}

			state = .downloading

			process(request: imageDownloader.downloadImage(imageRemoteURL: imageRemoteURLProvider.url))

		case .localImage:
			break
		}
	}

	func cancelPrefetching() {
		cancelRequest()
	}

	func cancelRequest() {
		if state != .downloaded {
			// if image is not downloaded then sets initial state
			// else if state is downloading then in `requestImage` method `process(request:)` method will not be called

			state = .initial
		}

		for cancellable in cancellables {
			cancellable.cancel()
		}

		cancellables = []
	}
}

extension ImageProvider: Equatable {
	public static func == (lhs: ImageProvider, rhs: ImageProvider) -> Bool {
		lhs.imageContent == rhs.imageContent &&
		lhs.cancellables == rhs.cancellables &&
		lhs.state == rhs.state &&
		lhs.mainQueue == rhs.mainQueue &&
		lhs.imageProcessingQueue == rhs.imageProcessingQueue
	}
}

extension ImageProvider: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(imageContent)
		hasher.combine(cancellables)
		hasher.combine(state)
		hasher.combine(mainQueue)
		hasher.combine(imageProcessingQueue)
	}
}

private extension ImageProvider {
	func requestImage(onComplete: @escaping OnComplete) {
		switch imageContent {
		case let .localImage(uiImageProvider):
			imageProcessingQueue.async { [weak self] in
				self?.send(result: .success(uiImageProvider.uiImage))
			}

		case let .remoteURL(imageRemoteURLProvider, imageDownloader, _):
			onCompletes.append(onComplete)

			if state == .downloading {
				return
			}

			state = .downloading

			process(request: imageDownloader.downloadImage(imageRemoteURL: imageRemoteURLProvider.url))
		}
	}

	func process(request: AnyPublisher<Data, Error>) {
		request
			.sink { [weak self] completion in
				guard let self = self else {
					return
				}

				guard let failure = completion.failure else {
					return
				}

				self.state = .failed
				self.send(result: .failure(.networkError(failure)))
			} receiveValue: { [weak self] receivedImageData in
				self?.imageProcessingQueue.async { [weak self] in
					self?.didReceive(imageData: receivedImageData)
				}
			}
			.store(in: &cancellables)
	}

	func didReceive(imageData: Data) {
		guard var uiImage = UIImage(data: imageData) else {
			state = .failed
			send(result: .failure(.notImageData(imageData)))
			return
		}

		state = .downloaded

		switch imageContent {
		case let .remoteURL(_, _, imageModifiers):
			let result: Result
			do {
				uiImage = try ComplexUIImageProvider(
					originalUIImageProvider: uiImage,
					modifiers: imageModifiers
				).uiImage
				result = .success(uiImage)
			} catch {
				result = .failure(.imageProcessingError(error))
			}

			mainQueue.async { [weak self] in
				self?.send(result: result)
			}

		case .localImage:
			assertionFailure("?")
		}
	}

	func send(result: Result) {
		for onComplete in onCompletes {
			onComplete(result)
		}

		onCompletes = []
	}

	func set(newImage: UIImage?, to imageView: UIImageView, shouldHideShimmer: Bool) {
		mainQueue.async {
			if shouldHideShimmer {
				UIView.transition(
					with: imageView,
					duration: .defaultAnimationDuration,
					options: .transitionCrossDissolve,
					animations: {
						imageView.hideShimmer()
						imageView.image = newImage
					},
					completion: nil
				)
			} else {
				imageView.image = newImage
			}
		}
	}
}
