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
	func setupUI() {
		navigationItem.title = "Section background example"

		view.backgroundColor = .systemGroupedBackground

		view.addSubviewForConstraintsUse(collectionView)

		NSLayoutConstraint.activate(collectionView.makeConstraints(to: view.safeAreaLayoutGuide))
	}

	func fillCollectionView() {
		do {
			let section1 = try PlainListSection(
				items: [
					AnKitPlayground.makePlainLabelItem(text: "1"),
					AnKitPlayground.makePlainLabelItem(text: "2"),
					AnKitPlayground.makePlainLabelItem(text: "3"),
					AnKitPlayground.makePlainLabelItem(text: "4"),
					AnKitPlayground.makePlainLabelItem(text: "5")
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
					AnKitPlayground.makePlainLabelItem(text: "6"),
					AnKitPlayground.makePlainLabelItem(text: "7"),
					AnKitPlayground.makePlainLabelItem(text: "8"),
					AnKitPlayground.makePlainLabelItem(text: "9"),
					AnKitPlayground.makePlainLabelItem(text: "10")
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
