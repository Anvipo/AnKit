//
//  ShuffleItemsVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 29.08.2021.
//

import AnKit
import UIKit

final class ShuffleItemsVC: BaseVC {
	private let buttonBottomOffset: CGFloat
	private lazy var collectionView = CollectionView()
	private lazy var button = Button()

	override init(output: BaseViewOutput?) {
		buttonBottomOffset = .defaultHorizontalOffset

		super.init(output: output)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		fillCollectionView()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		button.addDefaultCircleCorners()
		button.addDefaultShadow(
			// swiftlint:disable:next force_unwrapping
			shadowColor: button.backgroundColor!
		)

		setupCollectionViewContentInsets()
	}
}

private extension ShuffleItemsVC {
	var neededCollectionViewBottomInset: CGFloat {
		button.frame.height + buttonBottomOffset
	}

	func setupCollectionViewContentInsets() {
		collectionView.contentInset.bottom = neededCollectionViewBottomInset
		collectionView.verticalScrollIndicatorInsets.bottom = collectionView.contentInset.bottom
	}

	func didTapButton() {
		guard let section = collectionView.sections.last else {
			assertionFailure("?")
			return
		}

		do {
			try section.set(items: section.items.shuffled())

			try collectionView.set(
				sections: [section],
				animatingDifferences: shouldAnimateDifferences
			)
		} catch {
			assertionFailure(error.localizedDescription)
		}
	}

	func makeHeaderFooterItem(
		text: String,
		elementKind: String
	) -> CollectionViewSupplementaryItem {
		PlainLabelSupplemetaryItem(
			text: text,
			textColor: .label,
			textFont: .preferredFont(forTextStyle: .title1),
			tintColor: .systemIndigo,
			elementKind: elementKind,
			textInsets: .default(top: 14, bottom: 10),
			blurEffectStyle: .systemUltraThinMaterial,
			pinToVisibleBounds: true
		)
	}

	func makeItem(text: String) -> CollectionViewItem {
		PlainLabelItem(
			text: text,
			textColor: .label,
			textFont: .preferredFont(forTextStyle: .body),
			tintColor: .systemIndigo,
			textAlignment: .center,
			textInsets: NSDirectionalEdgeInsets(
				horizontalInset: .defaultHorizontalOffset,
				verticalInset: 8
			),
			dividerModel: .lineDefaultOffsetFromStart()
		)
	}

	func setupUI() {
		navigationItem.title = "Shuffle items example"

		button.setup(
			text: "Shuffle items",
			textColor: .white,
			textFont: .preferredFont(forTextStyle: .callout),
			tintColor: .systemIndigo,
			backgroundColor: .systemIndigo,
			contentEdgeInsets: UIEdgeInsets(
				top: 16,
				left: 8,
				bottom: 16,
				right: 8
			)
		) { [weak self] in
			self?.didTapButton()
		}

		[collectionView, button].addAsSubviewForConstraintsUse(to: view)

		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

			button.leadingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.leadingAnchor,
				constant: .defaultHorizontalOffset
			),
			button.trailingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.trailingAnchor,
				constant: -.defaultHorizontalOffset
			),
			button.bottomAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.bottomAnchor,
				constant: -buttonBottomOffset
			)
		])
	}

	func fillCollectionView() {
		do {
			let section = try PlainListSection(
				items: [
					makeItem(text: "1"),
					makeItem(text: "2"),
					makeItem(text: "3"),
					makeItem(text: "4"),
					makeItem(text: "5"),
					makeItem(text: "6"),
					makeItem(text: "7"),
					makeItem(text: "8"),
					makeItem(text: "9"),
					makeItem(text: "10")
				],
				headerItem: makeHeaderFooterItem(text: "Header", elementKind: "Header"),
				footerItem: makeHeaderFooterItem(text: "Footer", elementKind: "Footer")
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
