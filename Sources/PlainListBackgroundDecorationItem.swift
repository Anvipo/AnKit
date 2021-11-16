//
//  PlainListBackgroundDecorationItem.swift
//  AnKit
//
//  Created by Anvipo on 26.09.2021.
//

/// Background decoration item for plain list sections.
open class PlainListBackgroundDecorationItem: CollectionViewDecorationItem {
	/// If header exists, it will be ignored.
	public let ignoresHeader: Bool

	/// If footer exists, it will be ignored.
	public let ignoresFooter: Bool

	/// Initializes item with specified parameters.
	/// - Parameters:
	///   - elementKind: A string that identifies the type of supplementary item.
	///   - id: The stable identity of the entity associated with this instance.
	///   - ignoresHeader: If header exists, it will be ignored.
	///   - ignoresFooter: If footer exists, it will be ignored.
	public init(
		elementKind: String,
		ignoresHeader: Bool,
		ignoresFooter: Bool,
		id: ID = ID()
	) {
		self.ignoresHeader = ignoresHeader
		self.ignoresFooter = ignoresFooter

		super.init(
			elementKind: elementKind,
			id: id
		)
	}
}
