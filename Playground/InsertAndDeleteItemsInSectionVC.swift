//
//  InsertAndDeleteItemsInSectionVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 05.11.2021.
//

import AnKit
import UIKit

final class InsertAndDeleteItemsInSectionVC: BasePlaygroundVC {
	override class var playgroundTitle: String {
		"Insert & delete items example"
	}

	private lazy var insertButton = Button()
	private lazy var deleteButton = Button()
	// swiftlint:disable:next force_try
	private lazy var buttonsView = try! ButtonsView(
		buttons: [insertButton, deleteButton]
	)

	override var initialSections: [CollectionViewSection] {
		get throws {
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
				]
			)

			return [section]
		}
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		setupButtonsLayers()
		setupCollectionViewContentInsets()
	}

	override func setupUI() {
		super.setupUI()
		setupButtons()
	}
}

private extension InsertAndDeleteItemsInSectionVC {
	var neededCollectionViewBottomInset: CGFloat {
		buttonsView.frame.height
	}

	var section: CollectionViewSection {
		// swiftlint:disable:next force_unwrapping
		collectionView.sections.last!
	}

	func setupButtonsLayers() {
		for button in buttonsView.buttons {
			button.addDefaultCircleCorners()
		}
	}

	func setupCollectionViewContentInsets() {
		collectionView.contentInset.bottom = neededCollectionViewBottomInset
		collectionView.verticalScrollIndicatorInsets.bottom = collectionView.contentInset.bottom
	}

	func didTapDeleteButton() throws {
		var sectionItems = section.items

		sectionItems.remove(at: .random(in: 0..<sectionItems.count))

		if sectionItems.isEmpty {
			return
		}

		try section.set(items: sectionItems)

		try collectionView.set(
			sections: [section],
			animatingDifferences: shouldAnimateDifferences
		)
	}

	func didTapInsertButton() throws {
		var sectionItems = section.items

		let newItem = try AnKitPlayground.makePlainLabelItem(
			text: "\(sectionItems.count + 1)"
		)

		sectionItems.insert(newItem, at: .random(in: 0..<sectionItems.count))

		try section.set(items: sectionItems)

		try collectionView.set(
			sections: [section],
			animatingDifferences: shouldAnimateDifferences
		)
	}

	func setupButtons() {
		insertButton.setup(text: "Insert random item") { [weak self] in
			guard let self = self else {
				return
			}

			do {
				try self.didTapInsertButton()
			} catch {
				assertionFailure(error.localizedDescription)
			}
		}

		deleteButton.setup(text: "Delete random item") { [weak self] in
			guard let self = self else {
				return
			}

			do {
				try self.didTapDeleteButton()
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
