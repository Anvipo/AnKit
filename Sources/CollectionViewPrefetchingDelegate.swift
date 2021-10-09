//
//  CollectionViewPrefetchingDelegate.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import Foundation

/// A protocol that provides advance warning of the data requirements for a collection view,
/// allowing the triggering of asynchronous data load operations.
public protocol CollectionViewPrefetchingDelegate: AnyObject {
	/// Tells your prefetch data source object to begin preparing data for the cells at the supplied index paths.
	/// - Parameters:
	///   - collectionView: The collection view issuing the prefetch request.
	///   - indexPaths: The index paths that specify the locations of the items for which the data is to be prefetched.
	func collectionView(
		_ collectionView: CollectionView,
		prefetchItemsAt indexPaths: [IndexPath]
	)
}
