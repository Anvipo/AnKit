//
//  TableViewsVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 29.11.2021.
//

import AnKit
import UIKit

final class TableViewsVC: BasePlaygroundTableViewVC {
	override class var playgroundTitle: String {
		"Table views examples"
	}

	override var initialSections: [TableViewSection] {
		get throws {
			let exampleViewControllers: [PlaygroundVCProtocol.Type] = [
				SimpleTableViewVC.self
			]

			return [try makeSection(exampleViewControllers: exampleViewControllers)]
		}
	}
}

private extension TableViewsVC {
	func makeSection(exampleViewControllers: [PlaygroundVCProtocol.Type]) throws -> TableViewSection {
		try TableViewSection(
			items: exampleViewControllers.reduce(into: []) { partialResult, exampleVCType in
				let buttonItem = ButtonTVI(text: exampleVCType.playgroundTitle) { [weak self] in
					guard let self = self else {
						return
					}

					self.navigationController?.pushViewController(
						exampleVCType.init(),
						animated: self.shouldAnimate
					)
				}
				partialResult.append(buttonItem)
//				partialResult.append(try PlainSpacerItem(height: 32))
			}
		)
	}
}
