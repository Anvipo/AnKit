//
//  VerticalBadgedItemsVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 23.10.2021.
//

import AnKit
import UIKit

final class VerticalBadgedItemsVC: BaseVC {
	private let remoteImageCardHeight: CGFloat = 156
	private let remoteImageCardWidth: CGFloat = 102
	private lazy var collectionView = CollectionView()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		fillCollectionView()
	}
}

private extension VerticalBadgedItemsVC {
	func makeItem(
		id: Int
	) throws -> InfoCardItem {
		let remoteURLImageViewWidth = Int(remoteImageCardWidth)
		let remoteURLImageViewHeight = Int(remoteImageCardHeight * InfoCardCell.imageViewHeightMultiplier)
		// swiftlint:disable:next force_unwrapping
		let url = URL(string: "https://picsum.photos/id/1\(id)/\(remoteURLImageViewWidth)/\(remoteURLImageViewHeight)")!

		let badgeItem: InfoCardItem.BadgeItem?
		if Bool.random() {
			badgeItem = InfoCardItem.BadgeItem(
				text: "\(id)",
				elementKind: "Item badge \(id)",
				textColor: Color.white.uiColor,
				textFont: Font.callout.uiFont,
				textAlignment: .center,
				textNumberOfLines: 1,
				textInsets: .square(side: 4),
				containerAnchor: NSCollectionLayoutAnchor(
					edges: [.top, .trailing],
					fractionalOffset: CGPoint(x: 0.5, y: -0.5)
				),
				tintColor: .clear,
				backgroundColor: .red
			)
		} else {
			badgeItem = nil
		}

		return try InfoCardItem(
			content: InfoCardItem.Content(
				imageContent: .remoteURL(
					urlProvider: url,
					imageDownloader: URLSession(configuration: .ephemeral)
				),
				text: "\(id)"
			),
			imageViewContentMode: .scaleToFill,
			badgeItem: badgeItem
		)
	}

	func setupUI() {
		navigationItem.title = "Vertical badged items example"

		[collectionView].addAsSubviewForConstraintsUse(to: view)

		NSLayoutConstraint.activate(collectionView.makeConstraints(to: view.safeAreaLayoutGuide))
	}

	func fillCollectionView() {
		do {
			let firstSection = try VerticalBadgedItemsSection(
				items: stride(from: 1, to: Int.random(in: 15...25), by: 1).map { try makeItem(id: $0) },
				itemSize: NSCollectionLayoutSize(
					widthDimension: .absolute(remoteImageCardWidth),
					heightDimension: .absolute(remoteImageCardHeight)
				),
				headerItem: try AnKitPlayground.makePlainLabelSupplementaryItem(
					text: "Header",
					elementKind: "Header"
				),
				contentInsets: .default(top: 30)
			)

			try collectionView.set(
				sections: [firstSection],
				animatingDifferences: shouldAnimateDifferences
			)
		} catch {
			assertionFailure(error.localizedDescription)
		}
	}
}
