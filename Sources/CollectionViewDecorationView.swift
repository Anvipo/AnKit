//
//  CollectionViewDecorationView.swift
//  AnKit
//
//  Created by Anvipo on 23.10.2021.
//

import UIKit

/// Decoration views provide visual adornments to a section or to the entire collection view
/// but are not otherwise tied to the data provided by the collection view’s data source.
open class CollectionViewDecorationView: UICollectionReusableView {
	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	@available(*, unavailable)
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
