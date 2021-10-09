//
//  Item.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import Foundation

/// DTO for view.
open class Item {
	/// Content, which will be used for identifing item.
	public final var typeErasedContent: AnyHashable

	// swiftlint:disable:next missing_docs
	public final let id: ID

	/// Initialize item with specified parameters.
	/// - Parameters:
	///   - typeErasedContent: Content, which will be used for identifing item.
	///   - id: The stable identity of the entity associated with this instance.
	init(
		typeErasedContent: AnyHashable,
		id: ID
	) {
		self.typeErasedContent = typeErasedContent
		self.id = id
	}
}

extension Item: Equatable {
	public static func == (lhs: Item, rhs: Item) -> Bool {
		lhs.typeErasedContent == rhs.typeErasedContent &&
		lhs.id == rhs.id &&
		(lhs as? Tappable)?.canResponseToTap == (rhs as? Tappable)?.canResponseToTap &&
		(lhs as? Shimmerable)?.isShimmering == (rhs as? Shimmerable)?.isShimmering &&
		(lhs as? Dividerable)?.dividerModel == (rhs as? Dividerable)?.dividerModel &&
		(lhs as? HasImageProviders)?.imageProviders == (rhs as? HasImageProviders)?.imageProviders
	}
}

extension Item: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(typeErasedContent)
		hasher.combine(id)

		if let tappableItem = self as? Tappable {
			hasher.combine(tappableItem.canResponseToTap)
		}

		if let shimmerableItem = self as? Shimmerable {
			hasher.combine(shimmerableItem.isShimmering)
		}

		if let dividerableItem = self as? Dividerable {
			hasher.combine(dividerableItem.dividerModel)
		}

		if let hasImageProvidersItem = self as? HasImageProviders {
			hasher.combine(hasImageProvidersItem.imageProviders)
		}
	}
}

extension Item: Identifiable {
	public typealias ID = UUID
}
