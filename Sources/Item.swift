//
//  Item.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import Foundation

/// DTO for view.
open class Item {
	// swiftlint:disable:next missing_docs
	public final let id: ID

	/// Initialize item with specified parameters.
	/// - Parameter id: The stable identity of the entity associated with this instance.
	public init(id: ID) {
		self.id = id
	}

	// swiftlint:disable:next missing_docs
	open func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}

extension Item: Equatable {
	public static func == (
		lhs: Item,
		rhs: Item
	) -> Bool {
		lhs.id == rhs.id
	}
}

extension Item: Hashable {}

extension Item: Identifiable {
	public typealias ID = UUID
}
