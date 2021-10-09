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
	private let imageDownloader: ImageDownloader
	private let imageProcessingQueue: DispatchQueue
	private let mainQueue: DispatchQueue

	private var state: State
	private var cancellables: Set<AnyCancellable>
	private var onCompletes: [OnComplete]

	/// Initializes provider with specified parameters.
	/// - Parameters:
	///   - imageContent: Image content.
	///   - imageDownloader: Image downloader.
	///   - imageProcessingQueue: Image processing queue.
	///   - mainQueue: Main queue.
	public init(
		imageContent: ImageContent,
		imageDownloader: ImageDownloader,
		imageProcessingQueue: DispatchQueue,
		mainQueue: DispatchQueue = .main
	) {
		self.imageContent = imageContent
		self.imageDownloader = imageDownloader
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
	///   - transformationsBeforeSet: Action, which should be done before image set.
	///   - getCustomImageViewSize: Custom image view size, if needed.
	///   - shouldSetImageToImageView: Should set image to image view or not.
	func setupImage(
		in imageView: UIImageView,
		transformationsBeforeSet: ((UIImage) -> Void)? = nil,
		getCustomImageViewSize: (() -> CGSize)? = nil,
		shouldSetImageToImageView: @escaping () -> Bool = { true }
	) throws {
		if let uiImage = imageContent.uiImage {
			let redrawnImage: UIImage
			if let customImageViewSize = getCustomImageViewSize?() {
				redrawnImage = try uiImage.proportionallyRedraw(to: customImageViewSize)
			} else {
				redrawnImage = uiImage
			}

			transformationsBeforeSet?(redrawnImage)

			imageView.image = redrawnImage
			return
		}

		let shouldShimmer = state != .downloaded

		if shouldShimmer {
			imageView.showShimmer()
		}

		// swiftlint:disable:next closure_body_length
		try requestImage { [weak imageView, weak self] result in
			guard let self = self,
				  let imageView = imageView,
				  shouldSetImageToImageView()
			else {
				return
			}

			guard let newImage = result.success?.uiImage else {
				self.set(newImage: nil, to: imageView, shouldHideShimmer: shouldShimmer)
				return
			}

			if let customImageViewSize = getCustomImageViewSize?() {
				self.imageProcessingQueue.async { [weak self] in
					guard let self = self else {
						return
					}

					do {
						let redrawnImage = try newImage.proportionallyRedraw(to: customImageViewSize)

						self.set(
							newImage: redrawnImage,
							to: imageView,
							shouldHideShimmer: shouldShimmer
						)
					} catch {
						assertionFailure(error.localizedDescription)
					}
				}
			} else {
				self.set(newImage: newImage, to: imageView, shouldHideShimmer: shouldShimmer)
			}
		}
	}
}

extension ImageProvider {
	typealias Result = Swift.Result<UIImage, ProcessingError>
	typealias OnComplete = (Result) -> Void

	func prefetch() {
		guard let imageRemoteURL = imageContent.remoteURL else {
			return
		}

		if state == .downloading || state == .downloaded {
			return
		}

		state = .downloading

		process(request: imageDownloader.downloadImage(imageRemoteURL: imageRemoteURL))
	}

	func cancelPrefetching() {
		cancelRequest()
	}

	func cancelRequest() {
		if state != .downloaded {
			// раз не загрузили, то, чтобы всё-таки скачать картинку
			// устанавливаем нужное состояние
			// (иначе состояние будет, скорее всего, равно .downloading
			// и тогда в requestImage произойдёт уход в return и картинка не будет загружена)
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
	func requestImage(onComplete: @escaping OnComplete) throws {
		if let uiImage = imageContent.uiImage {
			mainQueue.async { [weak self] in
				self?.send(result: .success(uiImage))
			}
			return
		}

		guard let imageRemoteURL = imageContent.remoteURL else {
			throw RequestImageError.unknownContentType(imageContent)
		}

		onCompletes.append(onComplete)

		if state == .downloading {
			return
		}

		state = .downloading

		process(request: imageDownloader.downloadImage(imageRemoteURL: imageRemoteURL))
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
				guard let self = self else {
					return
				}

				guard let uiImage = UIImage(data: receivedImageData) else {
					self.state = .failed
					self.send(result: .failure(.notImageData(receivedImageData)))
					return
				}

				self.state = .downloaded
				self.send(result: .success(uiImage))
			}
			.store(in: &cancellables)
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
