//
//  SectionBackgroundVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 29.09.2021.
//

import AnKit
import UIKit

final class SectionBackgroundVC: BasePlaygroundVC {
	override class var playgroundTitle: String {
		"Section background example"
	}

	override var initialSections: [CollectionViewSection] {
		get throws {
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

			return sections
		}
	}

	override func setupUI() {
		super.setupUI()
		view.backgroundColor = .systemGroupedBackground
	}
}
