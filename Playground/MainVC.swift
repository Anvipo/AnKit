//
//  MainVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 28.09.2021.
//

import AnKit
import UIKit

final class MainVC: BasePlaygroundVC {
	override class var playgroundTitle: String {
		"Examples"
	}

	override var initialSections: [CollectionViewSection] {
		get throws {
			let exampleViewControllers: [PlaygroundVCProtocol.Type] = [
				SimpleVC.self,
				ShuffleItemsVC.self,
				SectionBackgroundVC.self,
				ScaleCarouselVC.self,
				VerticalBadgedItemsVC.self,
				InsertAndDeleteItemsInSectionVC.self,
				ChangeItemHeightVC.self,
				ChangeSectionLayoutVC.self
			]

			return [try makeSection(exampleViewControllers: exampleViewControllers)]
		}
	}
}

private extension MainVC {
	func makeSection(exampleViewControllers: [PlaygroundVCProtocol.Type]) throws -> PlainListSection {
		try PlainListSection(
			items: [PlainSpacerItem(height: .defaultVerticalOffset)] +
			exampleViewControllers.reduce(into: []) { partialResult, exampleVCType in
				let buttonItem = try ButtonItem(text: exampleVCType.playgroundTitle) { [weak self] in
					guard let self = self else {
						return
					}

					self.navigationController?.pushViewController(
						exampleVCType.init(),
						animated: self.shouldAnimate
					)
				}
				partialResult.append(buttonItem)
				partialResult.append(try PlainSpacerItem(height: 32))
			},
			contentInsets: .default()
		)
	}
}
