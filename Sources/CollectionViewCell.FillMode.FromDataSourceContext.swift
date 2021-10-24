//
//  CollectionViewCell.FillMode.FromDataSourceContext.swift
//  AnKit
//
//  Created by Anvipo on 23.10.2021.
//

public extension CollectionViewCell.FillMode {
	/// Context, which is filled from data source.
	struct FromDataSourceContext {
		/// Collection view, which owns cell.
		///
		/// Calling collection view datasource related methods is prohibited.
		public let collectionView: CollectionView

		/// Section, which owns cell.
		public let section: CollectionViewSection
	}
}
