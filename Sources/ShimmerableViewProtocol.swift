//
//  ShimmerableViewProtocol.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import CoreGraphics

/// Protocol for view which could shimmer.
public protocol ShimmerableViewProtocol {
	/// Show shimmer on view.
	func showShimmer()

	/// Hide shimmer on view.
	func hideShimmer()

	/// Lay out shimmer on view.
	func layoutShimmer()

	/// Lay out shimmer with specified `rect`.
	/// - Parameter rect: Rect for shimmer on view.
	func layoutShimmer(by rect: CGRect)
}

public extension Array where Element == ShimmerableViewProtocol {
	/// Show shimmers on views.
	func showShimmers() {
		for subview in self {
			subview.showShimmer()
		}
	}

	/// Hide shimmers on views.
	func hideShimmers() {
		for subview in self {
			subview.hideShimmer()
		}
	}

	/// Lay out shimmers on views.
	func layoutShimmers() {
		for subview in self {
			subview.layoutShimmer()
		}
	}
}
