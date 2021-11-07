//
//  InsertAndDeleteItemsInSectionVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 05.11.2021.
//

import AnKit
import UIKit

final class InsertAndDeleteItemsInSectionVC: BasePlaygroundVC {
	override var playgroundTitle: String {
		"Insert & delete items example"
	}

	private lazy var insertButton = Button()
	private lazy var deleteButton = Button()
	private lazy var buttonsView = ButtonsView(
		buttons: [insertButton, deleteButton]
	)

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		insertButton.addDefaultCircleCorners()
		insertButton.addDefaultShadow(
			// swiftlint:disable:next force_unwrapping
			shadowColor: insertButton.backgroundColor!
		)

		deleteButton.addDefaultCircleCorners()
		deleteButton.addDefaultShadow(
			// swiftlint:disable:next force_unwrapping
			shadowColor: deleteButton.backgroundColor!
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
			]
		)

		return [section]
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

	func setupCollectionViewContentInsets() {
		collectionView.contentInset.bottom = neededCollectionViewBottomInset
		collectionView.verticalScrollIndicatorInsets.bottom = collectionView.contentInset.bottom
	}

	func didTapDeleteButton() throws {
		guard let section = collectionView.sections.last else {
			assertionFailure("?")
			return
		}

		let sectionItems = try collectionView.items(in: section)

		if sectionItems.isEmpty {
			return
		}

		let randomIndex = Int.random(in: 0..<sectionItems.count)

		try collectionView.apply(
			snapshotTransaction: [.deleteItems([sectionItems[randomIndex]])],
			animatingDifferences: shouldAnimateDifferences
		)
	}

	func didTapInsertButton() throws {
		guard let section = collectionView.sections.last else {
			assertionFailure("?")
			return
		}

		let sectionItems = try collectionView.items(in: section)

		let newItem = try AnKitPlayground.makePlainLabelItem(text: "\(sectionItems.count)")

		let snapshotTransaction: CollectionView.SnapshotTransaction
		if sectionItems.isEmpty {
			snapshotTransaction = [
				.appendItems([newItem], toSection: section)
			]
		} else {
			let randomIndex = Int.random(in: 0..<sectionItems.count)

			snapshotTransaction = [
				.insertItemsAfterItem(
					[newItem],
					afterItem: sectionItems[randomIndex]
				)
			]
		}

		try collectionView.apply(
			snapshotTransaction: snapshotTransaction,
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
