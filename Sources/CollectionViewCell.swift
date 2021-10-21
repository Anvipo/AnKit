//
//  CollectionViewCell.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

/// A single data item when that item is within the collection view’s visible bounds.
open class CollectionViewCell: UICollectionViewCell {
	/// Views, which could be shimmered.
	public final var shimmerableViews: [ShimmerableViewProtocol]

	override public init(frame: CGRect) {
		shimmerableViews = []

		super.init(frame: frame)

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
	open func fill(from item: CollectionViewItem, mode: FillMode) {
		// no code
	}
}

extension CollectionViewCell {
	static var reuseIdentifier: String {
		// extracts full path (with framework name) to cell
		String(reflecting: self)
	}
}
