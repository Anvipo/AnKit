//
//  CollectionView.DataSourceError.swift
//  AnKit
//
//  Created by Anvipo on 12.09.2021.
//

import Foundation

public extension CollectionView {
	/// Error, which could be thrown from datasource methods.
	enum DataSourceError {
		/// Collection view already have specified section at specified `sectionIndexInSnapshot`.
		case existingSection(
			CollectionViewSection,
			sectionIndexInSnapshot: Int
		)

		/// Collection view's section already have specified item at specified `itemIndexInSnapshot`.
		case existingItem(
			CollectionViewItem,
			itemIndexInSnapshot: Int
		)

		/// Collection view's section already have specified item at specified `itemIndexInSnapshot`.
		case existingItemInSection(
			CollectionViewItem,
			CollectionViewSection,
			itemIndexInSnapshot: Int
		)

		/// Collection view does not have specified item.
		case notExistingItem(CollectionViewItem)

		/// Collection view does not have specified section.
		case notExistingSection(CollectionViewSection)

		/// Array of items has not unique items.
		case notUniqueItems([CollectionViewItem])

		/// Array of sections has not unique sections.
		case notUniqueSections([CollectionViewSection])
	}
}

extension CollectionView.DataSourceError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .existingSection(section, sectionIndexInSnapshot):
			return """
			Collection view already have section \(section) at index \(sectionIndexInSnapshot) in snapshot
			"""

		case let .existingItem(item, itemIndexInSnapshot):
			return """
			Collection view already have section \(item) at index \(itemIndexInSnapshot) in snapshot
			"""

		case let .existingItemInSection(item, section, itemIndexInSnapshot):
			return """
			Collection view already have item \(item) in section \(section) at index \(itemIndexInSnapshot) in snapshot
			"""

		case let .notExistingItem(item):
			return """
			Collection view does not have item \(item)
			"""

		case let .notExistingSection(section):
			return """
			Collection view does not have section \(section)
			"""

		case let .notUniqueItems(items):
			return """
			Items \(items) are not unique
			"""

		case let .notUniqueSections(sections):
			return """
			Sections \(sections) are not unique
			"""
		}
	}
}
