//
//  SimpleCollectionViewVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 03.10.2021.
//

import AnKit
import UIKit

final class SimpleCollectionViewVC: BasePlaygroundCollectionViewVC {
	override class var playgroundTitle: String {
		"Simple collection view screen example"
	}

	override var initialSections: [CollectionViewSection] {
		get throws {
			let section = try PlainListSection(
				items: [
					AnKitPlayground.makePlainLabelItem(text: "Text 1", dividerColor: .systemRed),
					AnKitPlayground.makePlainLabelItem(text: "Text 2", dividerColor: .systemRed),
					AnKitPlayground.makePlainLabelItem(text: "Text 3", dividerColor: .systemRed),
					AnKitPlayground.makePlainLabelItem(text: "Text 4", dividerColor: .systemRed),
					AnKitPlayground.makePlainLabelItem(text: "Text 5", dividerColor: .systemRed)
				]
			)

			return [section]
		}
	}
}
