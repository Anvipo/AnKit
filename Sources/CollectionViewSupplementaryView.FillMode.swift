//
//  CollectionViewSupplementaryView.FillMode.swift
//  AnKit
//
//  Created by Anvipo on 23.10.2021.
//

public extension CollectionViewSupplementaryView {
	/// `fill(from:mode:)` method mode.
	enum FillMode {
		/// Method is called from collection view data source.
		///
		/// Calling collection view datasource related methods is prohibited.
		case fromDataSource(CollectionView)

		/// Method is called from collection view layout.
		case fromLayout(LayoutMode)
	}
}
