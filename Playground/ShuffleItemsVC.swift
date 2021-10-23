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
		guard let section = collectionView.sections.last as? PlainListSection else {
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
				headerItem: AnKitPlayground.makePlainLabelSupplementaryItem(text: "Header", elementKind: "Header"),
				footerItem: AnKitPlayground.makePlainLabelSupplementaryItem(text: "Footer", elementKind: "Footer")
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
