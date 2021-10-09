//
//  CollectionViewDecorationItem.swift
//  AnKit
//
//  Created by Anvipo on 26.09.2021.
//

/// Item, which is anchored to the section.
open class CollectionViewDecorationItem: CollectionViewSupplementaryItem {
	/// Initializes item with specified parameters.
	/// - Parameters:
	///   - elementKind: A string that identifies the type of supplementary item.
	///   - id: The stable identity of the entity associated with this instance.
	public init(
		elementKind: String,
		id: ID = ID()
	) {
		super.init(
			typeErasedContent: elementKind,
			elementKind: elementKind,
			id: id
		)
	}
}
