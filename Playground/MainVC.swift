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

	func didTapScaleCarouselButtonItem() {
		navigationController?.pushViewController(
			ScaleCarouselVC(),
			animated: shouldAnimateDifferences
		)
	}

	func didTapVerticalBadgedItemsButtonItem() {
		navigationController?.pushViewController(
			VerticalBadgedItemsVC(),
			animated: shouldAnimateDifferences
		)
	}

	func setupUI() {
		navigationItem.title = "Examples"

		view.addSubviewForConstraintsUse(collectionView)
		NSLayoutConstraint.activate(collectionView.makeConstraints(to: view.safeAreaLayoutGuide))
	}

	func fillCollectionView() {
		do {
			let simpleScreenButtonItem = try ButtonItem(text: "Simple screen example") { [weak self] in
				self?.didTapSimpleScreenButtonItem()
			}
			let shuffleItemsButtonItem = try ButtonItem(text: "Shuffle items example") { [weak self] in
				self?.didTapShuffleItemsButtonItem()
			}
			let sectionBackgroundButtonItem = try ButtonItem(text: "Section background example") { [weak self] in
				self?.didTapSectionBackgroundButtonItem()
			}
			let scaleCarouselButtonItem = try ButtonItem(text: "Scale carousel example") { [weak self] in
				self?.didTapScaleCarouselButtonItem()
			}
			let verticalBadgedItemsVCButtonItem = try ButtonItem(text: "Vertical badged items example") { [weak self] in
				self?.didTapVerticalBadgedItemsButtonItem()
			}

			let section = try PlainListSection(
				items: [
					PlainSpacerItem(height: 16),
					simpleScreenButtonItem,
					PlainSpacerItem(height: 32),
					shuffleItemsButtonItem,
					PlainSpacerItem(height: 32),
					sectionBackgroundButtonItem,
					PlainSpacerItem(height: 32),
					scaleCarouselButtonItem,
					PlainSpacerItem(height: 32),
					verticalBadgedItemsVCButtonItem
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
