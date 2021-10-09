//
//  SectionBackgroundVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 29.09.2021.
//

import AnKit
import UIKit

final class SectionBackgroundVC: BaseVC {
	private lazy var collectionView = CollectionView()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		fillCollectionView()
	}
}

private extension SectionBackgroundVC {
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
		navigationItem.title = "Section background example"

		view.backgroundColor = .systemGroupedBackground

		[collectionView].addAsSubviewForConstraintsUse(to: view)

		NSLayoutConstraint.activate(collectionView.makeConstraints(to: view.safeAreaLayoutGuide))
	}

	func fillCollectionView() {
		do {
			let section1 = try PlainListSection(
				items: [
					makeItem(text: "1"),
					makeItem(text: "2"),
					makeItem(text: "3"),
					makeItem(text: "4"),
					makeItem(text: "5")
				],
				backgroundDecorationItem: SecondarySystemGroupedBackgroundDecorationItem(
					elementKind: "SecondarySystemGroupedBackgroundDecorationItem",
					ignoresHeader: true,
					ignoresFooter: true
				),
				contentInsets: .default(top: 30, bottom: 40)
			)

			let section2 = try PlainListSection(
				items: [
					makeItem(text: "6"),
					makeItem(text: "7"),
					makeItem(text: "8"),
					makeItem(text: "9"),
					makeItem(text: "10")
				],
				backgroundDecorationItem: SecondarySystemGroupedBackgroundDecorationItem(
					elementKind: "SecondarySystemGroupedBackgroundDecorationItem",
					ignoresHeader: true,
					ignoresFooter: true
				),
				contentInsets: .default()
			)

			let sections = [section1, section2]

			let dividerStrategy = DividerDefaultStrategy()
			dividerStrategy.separateItems(in: sections)

			try collectionView.set(
				sections: sections,
				animatingDifferences: shouldAnimateDifferences
			)
		} catch {
			assertionFailure(error.localizedDescription)
		}
	}
}
