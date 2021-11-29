//
//  TableViewCell.FillMode.FromDataSourceContext.swift
//  AnKit
//
//  Created by Anvipo on 29.11.2021.
//

import CoreGraphics

public extension TableViewCell.FillMode {
	/// Context, which is filled from data source.
	struct FromDataSourceContext {
		/// Table view, which owns cell.
		///
		/// Calling table view datasource related methods is prohibited.
		public let tableView: TableView

		/// Section, which owns cell.
		public let section: TableViewSection
	}
}
