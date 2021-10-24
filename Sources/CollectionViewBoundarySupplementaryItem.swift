//
//  CollectionViewBoundarySupplementaryItem.swift
//  AnKit
//
//  Created by Anvipo on 24.10.2021.
//

import UIKit

/// The supplementary item that is associated with the boundary edges of the section, such as headers and footers
/// or the entire collection view.
open class CollectionViewBoundarySupplementaryItem: CollectionViewSupplementaryItem {
	/// A Boolean value that indicates whether a view is pinned
	/// to the top or bottom visible boundary of the section or layout it's attached to.
	public let pinToVisibleBounds: Bool

	/// Initializes item with specified parameters.
	/// - Parameters:
	///   - elementKind: A string that identifies the type of supplementary item.
	///   - pinToVisibleBounds: A Boolean value that indicates whether a view is pinned
	/// to the top or bottom visible boundary of the section or layout it's attached to.
	///   - contentInsets: The amount of space between the content of the item and its boundaries.
	///   - id: The stable identity of the entity associated with this instance.
	public init(
		elementKind: String,
		pinToVisibleBounds: Bool = false,
		contentInsets: NSDirectionalEdgeInsets = .zero,
		id: ID = ID()
	) {
		self.pinToVisibleBounds = pinToVisibleBounds

		super.init(
			elementKind: elementKind,
			contentInsets: contentInsets,
			id: id
		)
	}

	override open func hash(into hasher: inout Hasher) {
		super.hash(into: &hasher)

		hasher.combine(pinToVisibleBounds)
	}
}

public extension CollectionViewBoundarySupplementaryItem {
	// swiftlint:disable:next missing_docs
	static func == (
		lhs: CollectionViewBoundarySupplementaryItem,
		rhs: CollectionViewBoundarySupplementaryItem
	) -> Bool {
		(lhs as CollectionViewSupplementaryItem) == (rhs as CollectionViewSupplementaryItem) &&

		lhs.pinToVisibleBounds == rhs.pinToVisibleBounds
	}
}
