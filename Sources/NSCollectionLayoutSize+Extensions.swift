//
//  NSCollectionLayoutSize+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 16.11.2021.
//

import UIKit

public extension NSCollectionLayoutSize {
	/// Size of item, which fills all width and height of container (group or section).
	static var fullSize: Self {
		Self(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		)
	}

	/// Returns size of item, which fills all width of container (group or section) and with specified `heightDimension`.
	/// - Parameter heightDimension: An individual dimension of an item's height in a collection view.
	static func fullWidth(
		heightDimension: NSCollectionLayoutDimension
	) -> Self {
		Self(
			widthDimension: .fractionalWidth(1),
			heightDimension: heightDimension
		)
	}

	/// Returns size of item, which fills all height of container (group or section) and with specified `widthDimension`.
	/// - Parameter widthDimension: An individual dimension of an item's width in a collection view.
	static func fullHeight(
		widthDimension: NSCollectionLayoutDimension
	) -> Self {
		Self(
			widthDimension: widthDimension,
			heightDimension: .fractionalHeight(1)
		)
	}

	/// Returns size of square item with specified `fractionalWidth`.
	/// - Parameter fractionalWidth: A dimension, which is computed as a fraction of the width of the containing group or section.
	static func square(fractionalWidth: CGFloat) -> Self {
		Self(
			widthDimension: .fractionalWidth(fractionalWidth),
			heightDimension: .fractionalWidth(fractionalWidth)
		)
	}

	/// Returns size of square item with specified `fractionalHeight`.
	/// - Parameter fractionalHeight: A dimension, which is computed as a fraction of the height of the containing group or section.
	static func square(fractionalHeight: CGFloat) -> Self {
		Self(
			widthDimension: .fractionalHeight(fractionalHeight),
			heightDimension: .fractionalHeight(fractionalHeight)
		)
	}
}
