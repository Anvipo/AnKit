//
//  ChangeSectionLayoutVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 10.11.2021.
//

import AnKit
import UIKit

final class ChangeSectionLayoutVC: BasePlaygroundVC {
	override class var playgroundTitle: String {
		"Change layout section example"
	}

	private var listItems: [ColoredItem] = []
	private lazy var layoutMenu = UIMenu(
		title: "Select layout",
		options: [.displayInline],
		children: [
			UIAction(title: "Cards list") { [weak self] _ in
				try? self?.didTapToCardsListLayoutButton()
			},
			UIAction(title: "3 small under 1 big") { [weak self] _ in
				try? self?.didTapToThreeSmallUnderOneBigLayoutButton()
			},
			UIAction(title: "Grid") { [weak self] _ in
				try? self?.didTapToGridLayoutButton()
			},
			UIAction(title: "Plain list") { [weak self] _ in
				try? self?.didTapToPlainListLayoutButton()
			}
		]
	)

	override var initialSections: [CollectionViewSection] {
		get throws {
			listItems = [
				try ColoredItem(color: .systemRed),
				try ColoredItem(color: .systemOrange),
				try ColoredItem(color: .systemYellow),
				try ColoredItem(color: .systemGreen),
				try ColoredItem(color: .systemTeal),
				try ColoredItem(color: .systemBlue),
				try ColoredItem(color: .systemPurple)
			]

			return [
				try ChangeLayoutSection(
					mode: .plainListLayout,
					items: listItems
				)
			]
		}
	}

	override func setupUI() {
		super.setupUI()

		let rightBarButtonItem: UIBarButtonItem
		if #available(iOS 14, *) {
			rightBarButtonItem = UIBarButtonItem(
				title: "Layout",
				image: nil,
				primaryAction: nil,
				menu: layoutMenu
			)
		} else {
			rightBarButtonItem = UIBarButtonItem(
				title: "Layout",
				style: .plain,
				target: self,
				action: #selector(showSelectLayoutAlert)
			)
		}
		navigationItem.rightBarButtonItem = rightBarButtonItem
	}
}

private extension ChangeSectionLayoutVC {
	var section: ChangeLayoutSection {
		// swiftlint:disable:next force_cast
		collectionView.sections.first as! ChangeLayoutSection
	}

	var gridItems: [ColoredItem] {
		get throws {
			listItems +
			[
				try ColoredItem(color: .systemPink),
				try ColoredItem(color: .systemBrown),
				try ColoredItem(color: .systemIndigo),
				try ColoredItem(color: .systemGray)
			]
		}
	}

	var threeSmallUnderOneBigItems: [ColoredItem] {
		get throws {
			listItems +
			[
				try ColoredItem(color: .systemIndigo)
			]
		}
	}

	var cardsListItems: [ColoredItem] {
		get throws {
			var result = listItems + [
				try ColoredItem(color: .systemPink),
				try ColoredItem(color: .systemBrown),
				try ColoredItem(color: .systemIndigo),
				try ColoredItem(color: .systemGray)
			]

			result.remove(at: .random(in: 1...(result.count - 1)))
			result.remove(at: .random(in: 1...(result.count - 1)))
			result.remove(at: .random(in: 1...(result.count - 1)))

			return result
		}
	}

	func makeLocalImageItem(
		text: String
	) throws -> InfoCardItem {
		try InfoCardItem(
			content: InfoCardItem.Content(
				imageContent: .localImage(
					uiImageProvider: try Image.star.complexProvider(
						modifiers: [
							.tintColored(Color.brand.uiColor)
						]
					)
				),
				text: text
			),
			imageViewContentMode: .center
		)
	}

	func didTapToCardsListLayoutButton() throws {
		section.mode = .cardsListLayout
		try section.set(items: try cardsListItems)

		try collectionView.set(
			sections: [section],
			animatingDifferences: shouldAnimateDifferences
		)
	}

	func didTapToThreeSmallUnderOneBigLayoutButton() throws {
		section.mode = .threeSmallUnderOneBigLayout
		try section.set(items: try threeSmallUnderOneBigItems)

		try collectionView.set(
			sections: [section],
			animatingDifferences: shouldAnimateDifferences
		)
	}

	func didTapToGridLayoutButton() throws {
		section.mode = .gridLayout
		try section.set(items: try gridItems)

		try collectionView.set(
			sections: [section],
			animatingDifferences: shouldAnimateDifferences
		)
	}

	func didTapToPlainListLayoutButton() throws {
		section.mode = .plainListLayout
		try section.set(items: listItems)

		try collectionView.set(
			sections: [section],
			animatingDifferences: shouldAnimateDifferences
		)
	}

	@objc
	func showSelectLayoutAlert() {
		let alertController = UIAlertController(title: "Select layout", message: nil, preferredStyle: .alert)

		[
			UIAlertAction(title: "Cards list", style: .default) { [weak self] _ in
				try? self?.didTapToCardsListLayoutButton()
			},
			UIAlertAction(title: "3 small under 1 big", style: .default) { [weak self] _ in
				try? self?.didTapToThreeSmallUnderOneBigLayoutButton()
			},
			UIAlertAction(title: "Grid", style: .default) { [weak self] _ in
				try? self?.didTapToGridLayoutButton()
			},
			UIAlertAction(title: "Plain list", style: .default) { [weak self] _ in
				try? self?.didTapToPlainListLayoutButton()
			}
		].forEach(alertController.addAction(_:))

		present(alertController, animated: shouldAnimateDifferences)
	}
}
