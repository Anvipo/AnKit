//
//  CollectionViewDecorationItem.swift
//  AnKit
//
//  Created by Anvipo on 26.09.2021.
//

/// Item, which is anchored to the section.
open class CollectionViewDecorationItem: Item {
	/// A string that identifies the type of decoration view.
	///
	/// Must be same in all collection view lifecycle.
	public let elementKind: String

	/// Type for decoration view.
	open var decorationViewType: CollectionViewDecorationView.Type {
		fatalError("Implement this method in your class")
	}

	/// Initializes item with specified parameters.
	/// - Parameters:
	///   - elementKind: A string that identifies the type of decoration item.
	///   - id: The stable identity of the entity associated with this instance.
	public init(
		elementKind: String,
		id: ID = ID()
	) {
		self.elementKind = elementKind

		super.init(
			typeErasedContent: elementKind,
			id: id
		)
	}
}
