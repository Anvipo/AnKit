//
//  ScaleCarouselVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 17.10.2021.
//

import AnKit
import UIKit

final class ScaleCarouselVC: BasePlaygroundVC {
	override class var playgroundTitle: String {
		"Scale carousel example"
	}

	private let remoteImageCardHeight: CGFloat = 156
	private let remoteImageCardWidth: CGFloat = 102
	private let localImageCardSide: CGFloat = 80

	override var initialSections: [CollectionViewSection] {
		get throws {
			let firstSection = try ScaleCarouselSection(
				items: [
					makeRemoteImageItem(id: 1),
					makeRemoteImageItem(id: 2),
					makeRemoteImageItem(id: 3),
					makeRemoteImageItem(id: 4),
					makeRemoteImageItem(id: 5),
					makeRemoteImageItem(id: 6),
					makeRemoteImageItem(id: 7),
					makeRemoteImageItem(id: 8),
					makeRemoteImageItem(id: 9),
					makeRemoteImageItem(id: 10)
				],
				itemWidthDimension: .absolute(remoteImageCardWidth),
				itemHeightDimension: .absolute(remoteImageCardHeight),
				contentInsets: .default()
			)

			let secondSection = try ScaleCarouselSection(
				items: [
					makeLocalImageItem(text: "1"),
					makeLocalImageItem(text: "2"),
					makeLocalImageItem(text: "3"),
					makeLocalImageItem(text: "4"),
					makeLocalImageItem(text: "5"),
					makeLocalImageItem(text: "6"),
					makeLocalImageItem(text: "7"),
					makeLocalImageItem(text: "8"),
					makeLocalImageItem(text: "9"),
					makeLocalImageItem(text: "10")
				],
				itemWidthDimension: .absolute(localImageCardSide),
				itemHeightDimension: .absolute(localImageCardSide),
				contentInsets: .default(top: 32)
			)

			return [firstSection, secondSection]
		}
	}
}

private extension ScaleCarouselVC {
	func makeRemoteImageItem(
		id: Int
	) throws -> InfoCardItem {
		let remoteURLImageViewWidth = Int(remoteImageCardWidth)
		let remoteURLImageViewHeight = Int(remoteImageCardHeight * InfoCardCell.imageViewHeightMultiplier)
		// swiftlint:disable:next force_unwrapping
		let url = URL(string: "https://picsum.photos/id/1\(id)/\(remoteURLImageViewWidth)/\(remoteURLImageViewHeight)")!

		return try InfoCardItem(
			content: InfoCardItem.Content(
				imageContent: .remoteURL(
					urlProvider: url,
					imageDownloader: URLSession(configuration: .ephemeral)
				),
				text: "\(id)"
			),
			imageViewContentMode: .scaleToFill
		)
	}

	func makeLocalImageItem(
		text: String
	) throws -> InfoCardItem {
		try InfoCardItem(
			content: InfoCardItem.Content(
				imageContent: .localImage(
					uiImageProvider: try Image.star.complexProvider(
						modifiers: [
							.proportionallyResized(targetSize: .square(side: localImageCardSide / 2)),
							.tintColored(Color.brand.uiColor)
						]
					)
				),
				text: text
			),
			imageViewContentMode: .center
		)
	}
}
