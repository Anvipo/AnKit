//
//  MainVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 28.09.2021.
//

import AnKit
import UIKit

final class MainVC: BasePlaygroundVC {
	override var playgroundTitle: String {
		"Examples"
	}

	override func initialSections() throws -> [CollectionViewSection] {
		let exampleViewControllers: [BasePlaygroundVC] = [
			SimpleVC(),
			ShuffleItemsVC(),
			SectionBackgroundVC(),
			ScaleCarouselVC(),
			VerticalBadgedItemsVC(),
			InsertAndDeleteItemsInSectionVC()
		]

		return [try makeSection(exampleViewControllers: exampleViewControllers)]
	}
}

private extension MainVC {
	func makeSection(exampleViewControllers: [BasePlaygroundVC]) throws -> PlainListSection {
		try PlainListSection(
			items: [PlainSpacerItem(height: .defaultVerticalOffset)] +
			exampleViewControllers.reduce(into: []) { partialResult, exampleVC in
				let buttonItem = try ButtonItem(text: exampleVC.playgroundTitle) { [weak self] in
					guard let self = self else {
						return
					}

					self.navigationController?.pushViewController(
						exampleVC,
						animated: self.shouldAnimateDifferences
					)
				}
				partialResult.append(buttonItem)
				partialResult.append(try PlainSpacerItem(height: 32))
			},
			contentInsets: .default()
		)
	}
}
