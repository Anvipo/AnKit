//
//  ListSection.swift
//  AnKit
//
//  Created by Anvipo on 22.09.2021.
//

import UIKit

/// List-based section.
///
/// Behaves like in table view.
@available(iOS 14, *)
public final class ListSection: CollectionViewSection {
	private let configuration: UICollectionLayoutListConfiguration

	/// Initializes section with specified parameters.
	/// - Parameters:
	///   - configuration: A configuration for creating a list layout.
	///   - items: Items in section. Must not be empty.
	///   - supplementaryItems: Supplementary items in section. Could be empty.
	///   - id: The stable identity of the entity associated with this instance.
	public init(
		configuration: UICollectionLayoutListConfiguration,
		items: [CollectionViewItem],
		supplementaryItems: [String: CollectionViewSupplementaryItem] = [:],
		id: ID = ID()
	) throws {
		self.configuration = configuration

		try super.init(
			items: items,
			supplementaryItems: supplementaryItems,
			id: id
		)
	}

	override public func layoutConfiguration(
		layoutEnvironment: NSCollectionLayoutEnvironment
	) -> NSCollectionLayoutSection {
		NSCollectionLayoutSection.list(
			using: configuration,
			layoutEnvironment: layoutEnvironment
		)
	}
}
