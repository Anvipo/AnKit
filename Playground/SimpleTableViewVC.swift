//
//  SimpleTableViewVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 29.11.2021.
//

import AnKit
import UIKit

final class SimpleTableViewVC: BasePlaygroundTableViewVC {
	override class var playgroundTitle: String {
		"Simple table view screen example"
	}

	override var initialSections: [TableViewSection] {
		get throws {
			let section = try TableViewSection(
				items: [
					ColoredTVI(color: .systemRed),
					ColoredTVI(color: .systemYellow),
					ColoredTVI(color: .systemGreen),
					ColoredTVI(color: .systemBlue)
				]
			)

			return [section]
		}
	}
}
