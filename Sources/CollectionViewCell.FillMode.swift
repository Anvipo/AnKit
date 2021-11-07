//
//  CollectionViewCell.FillMode.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import CoreGraphics

public extension CollectionViewCell {
	/// `fill(from:mode:)` method mode.
	enum FillMode {
		/// Method is called from collection view data source.
		case fromDataSource(context: FromDataSourceContext)

		/// Method is called from collection view layout.
		case fromLayout(layoutMode: LayoutMode)
	}
}

public extension CollectionViewCell.FillMode {
	/// Available width for cell.
	var availableWidthForCell: CGFloat? {
		switch self {
		case let .fromDataSource(context):
			return context.availableWidthForCell

		case let .fromLayout(layoutMode):
			switch layoutMode {
			case let .heightCalculation(context):
				return context.availableWidthForCell

			case .widthCalculation:
				return nil
			}
		}
	}
}
