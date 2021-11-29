//
//  TableViewItem.swift
//  AnKit
//
//  Created by Anvipo on 29.11.2021.
//

/// Abstract DTO for cell.
open class TableViewItem: Item {
	/// Type for cell, which will be created and filled from this item.
	open var cellType: TableViewCell.Type {
		fatalError("Implement this method in your class")
	}
}
