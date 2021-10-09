//
//  CollectionView.SnapshotAction.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

public extension CollectionView {
	/// Action, which could be applied for snapshot in collection view.
	enum SnapshotAction {
		/// Sets specified `sections` in collection view.
		case setSections([CollectionViewSection])

		/// Deletes the sections with the specified identifiers from the snapshot.
		case deleteSections([CollectionViewSection])

		/// Adds the sections with the specified identifiers to the snapshot.
		case appendSections([CollectionViewSection])

		/// Deletes the items with the specified identifiers from the snapshot.
		case deleteItems([CollectionViewItem])

		/// Adds the items with the specified identifiers to the specified section of the snapshot.
		///
		/// If no section is provided, the items are appended to the last section of the snapshot.
		case appendItems([CollectionViewItem], toSection: CollectionViewSection?)

		/// Inserts the provided items immediately after the item with the specified identifier in the snapshot.
		case insertItemsAfterItem([CollectionViewItem], afterItem: CollectionViewItem)

		/// Inserts the provided sections immediately after the section with the specified identifier in the snapshot.
		case insertSectionsAfterSection([CollectionViewSection], afterSection: CollectionViewSection)

		/// Reloads the data within the specified items in the snapshot.
		case reloadItems([CollectionViewItem])

		/// Reloads the data within the specified sections of the snapshot.
		case reloadSections([CollectionViewSection])

		/// Updates the data for the items you specify in the snapshot, preserving the existing cells for the items.
		///
		/// Works only in iOS 15 or later.
		case reconfigureItems([CollectionViewItem])

		/// Updates the data for the items you specify in the snapshot, preserving the existing cells for the items, if iOS version is 15 or older
		/// else Reloads the data within the specified items in the snapshot.
		case reconfigureOrReloadItems([CollectionViewItem])
	}
}

extension CollectionView.SnapshotAction: Equatable {}

extension CollectionView.SnapshotAction: Hashable {}
