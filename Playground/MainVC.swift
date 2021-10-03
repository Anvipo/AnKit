//
//  MainVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 28.09.2021.
//

import AnKit
import UIKit

final class MainVC: BaseVC {
	private lazy var collectionView = CollectionView()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		fillCollectionView()
	}
}

private extension MainVC {
	func didTapSimpleScreenButtonItem() {
		navigationController?.pushViewController(
			SimpleVC(),
			animated: shouldAnimateDifferences
		)
	}

	func didTapShuffleItemsButtonItem() {
		navigationController?.pushViewController(
			ShuffleItemsVC(),
			animated: shouldAnimateDifferences
		)
	}

	func didTapSectionBackgroundButtonItem() {
		navigationController?.pushViewController(
			SectionBackgroundVC(),
			animated: shouldAnimateDifferences
		)
	}

	func setupUI() {
		navigationItem.title = "Examples"

		[collectionView].addAsSubviewForConstraintsUse(to: view)
		NSLayoutConstraint.activate(collectionView.makeConstraints(to: view.safeAreaLayoutGuide))
	}

	func fillCollectionView() {
		do {
			let simpleScreenButtonItem = ButtonItem(text: "Simple screen example") { [weak self] in
				self?.didTapSimpleScreenButtonItem()
			}
			let shuffleItemsButtonItem = ButtonItem(text: "Shuffle items example") { [weak self] in
				self?.didTapShuffleItemsButtonItem()
			}
			let sectionBackgroundButtonItem = ButtonItem(text: "Section background example") { [weak self] in
				self?.didTapSectionBackgroundButtonItem()
			}

			let section = try PlainListSection(
				items: [
					simpleScreenButtonItem,
					PlainSpacerItem(height: 32),
					shuffleItemsButtonItem,
					PlainSpacerItem(height: 32),
					sectionBackgroundButtonItem
				],
				contentInsets: .default()
			)

			try collectionView.set(
				sections: [section],
				animatingDifferences: shouldAnimateDifferences
			)
		} catch {
			assertionFailure(error.localizedDescription)
		}
	}
}
