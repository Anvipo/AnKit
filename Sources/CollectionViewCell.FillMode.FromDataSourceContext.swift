//
//  CollectionViewCell.FillMode.FromDataSourceContext.swift
//  AnKit
//
//  Created by Anvipo on 23.10.2021.
//

import CoreGraphics

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

public extension CollectionViewCell.FillMode.FromDataSourceContext {
	/// Available width for cell.
	var availableWidthForCell: CGFloat {
		collectionView.frame.width -
		section.contentInsets.leading -
		section.contentInsets.trailing
	}
}
