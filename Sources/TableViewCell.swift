//
//  TableViewCell.swift
//  AnKit
//
//  Created by Anvipo on 29.11.2021.
//

import UIKit

/// A single data item when that item is within the collection view’s visible bounds.
open class TableViewCell: UITableViewCell {
	/// Views, which could be shimmered.
	public final var shimmerableViews: [ShimmerableViewProtocol]

	override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		shimmerableViews = []

		super.init(style: style, reuseIdentifier: reuseIdentifier)

		backgroundColor = .clear
	}

	@available(*, unavailable)
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override open func layoutSubviews() {
		super.layoutSubviews()
		shimmerableViews.layoutShimmers()
	}

	/// Fills cell by data in item.
	/// - Parameters:
	///   - item: Item for cell.
	///   - mode: Context for method calling.
	open func fill(from item: TableViewItem, mode: FillMode) {
		// no code
	}
}

extension TableViewCell {
	static var reuseIdentifier: String {
		// extracts full path (with framework name) to cell
		String(reflecting: self)
	}
}
