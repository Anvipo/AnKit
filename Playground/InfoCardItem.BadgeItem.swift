//
//  InfoCardItem.BadgeItem.swift
//  AnKitPlayground
//
//  Created by Anvipo on 23.10.2021.
//

import AnKit
import UIKit

extension InfoCardItem {
	final class BadgeItem: CollectionViewSupplementaryItem {
		let text: String
		let textColor: UIColor
		let textFont: UIFont
		let textAlignment: NSTextAlignment
		let textNumberOfLines: Int
		let textInsets: NSDirectionalEdgeInsets
		let containerAnchor: NSCollectionLayoutAnchor

		let tintColor: UIColor
		let backgroundColor: UIColor

		override var supplementaryViewType: CollectionViewSupplementaryView.Type {
			InfoCardItem.BadgeView.self
		}

		init(
			text: String,
			elementKind: String,
			textColor: UIColor,
			textFont: UIFont,
			textAlignment: NSTextAlignment,
			textNumberOfLines: Int,
			textInsets: NSDirectionalEdgeInsets,
			containerAnchor: NSCollectionLayoutAnchor,
			tintColor: UIColor,
			backgroundColor: UIColor,
			id: ID = ID()
		) {
			self.text = text
			self.textColor = textColor
			self.textFont = textFont
			self.textAlignment = textAlignment
			self.textNumberOfLines = textNumberOfLines
			self.textInsets = textInsets
			self.containerAnchor = containerAnchor
			self.tintColor = tintColor
			self.backgroundColor = backgroundColor

			super.init(
				elementKind: elementKind,
				id: id
			)
		}
	}
}
