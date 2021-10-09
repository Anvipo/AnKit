//
//  CollectionViewSupplementaryView.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

/// A view that defines the behavior for all supplementary views presented by a collection view.
open class CollectionViewSupplementaryView: UICollectionReusableView {
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

	/// Fills view by data in item.
	/// - Parameters:
	///   - item: Item for view.
	///   - context: Context.
	open func fill(
		from item: CollectionViewSupplementaryItem,
		context: FillContext
	) {
		// no code
	}
}

extension CollectionViewSupplementaryView {
	static var reuseIdentifier: String {
		// extracts full path (with framework name) to view
		String(reflecting: self)
	}
}
