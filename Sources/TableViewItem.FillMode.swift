//
//  TableViewCell.FillMode.swift
//  AnKit
//
//  Created by Anvipo on 29.11.2021.
//

public extension TableViewCell {
	/// `fill(from:mode:)` method mode.
	enum FillMode {
		/// Method is called from collection view data source.
		case fromDataSource(context: FromDataSourceContext)

		/// Method is called from collection view layout.
		case fromLayout
	}
}
