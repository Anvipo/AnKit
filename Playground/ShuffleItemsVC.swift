//
//  ShuffleItemsVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 29.08.2021.
//

import AnKit
import UIKit

final class ShuffleItemsVC: BasePlaygroundVC {
	override class var playgroundTitle: String {
		"Shuffle items example"
	}

	private lazy var button = Button()
	private lazy var buttonsView = ButtonsView(button: button)

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		button.addDefaultCircleCorners()
		button.addDefaultShadow(
			// swiftlint:disable:next force_unwrapping
			shadowColor: button.backgroundColor!
		)

		setupCollectionViewContentInsets()
	}

	override func initialSections() throws -> [CollectionViewSection] {
		let section = try PlainListSection(
			items: [
				AnKitPlayground.makePlainLabelItem(text: "1"),
				AnKitPlayground.makePlainLabelItem(text: "2"),
				AnKitPlayground.makePlainLabelItem(text: "3"),
				AnKitPlayground.makePlainLabelItem(text: "4"),
				AnKitPlayground.makePlainLabelItem(text: "5"),
				AnKitPlayground.makePlainLabelItem(text: "6"),
				AnKitPlayground.makePlainLabelItem(text: "7"),
				AnKitPlayground.makePlainLabelItem(text: "8"),
				AnKitPlayground.makePlainLabelItem(text: "9"),
				AnKitPlayground.makePlainLabelItem(text: "10")
			],
			headerItem: AnKitPlayground.makePlainLabelBoundarySupplementaryItem(
				text: "Header",
				elementKind: "Header"
			),
			footerItem: AnKitPlayground.makePlainLabelBoundarySupplementaryItem(
				text: "Footer",
				elementKind: "Footer"
			)
		)

		return [section]
	}

	override func setupUI() {
		super.setupUI()
		setupButton()
	}
}

private extension ShuffleItemsVC {
	var neededCollectionViewBottomInset: CGFloat {
		buttonsView.frame.height
	}

	func setupCollectionViewContentInsets() {
		collectionView.contentInset.bottom = neededCollectionViewBottomInset
		collectionView.verticalScrollIndicatorInsets.bottom = collectionView.contentInset.bottom
	}

	func didTapButton() throws {
		guard let section = collectionView.sections.last as? PlainListSection else {
			assertionFailure("?")
			return
		}

		try section.set(items: section.items.shuffled())

		try collectionView.set(
			sections: [section],
			animatingDifferences: shouldAnimateDifferences
		)
	}

	func setupButton() {
		button.setup(
			text: "Shuffle items"
		) { [weak self] in
			guard let self = self else {
				return
			}

			do {
				try self.didTapButton()
			} catch {
				assertionFailure(error.localizedDescription)
			}
		}

		view.addSubviewForConstraintsUse(buttonsView)

		NSLayoutConstraint.activate([
			buttonsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			buttonsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			buttonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}
