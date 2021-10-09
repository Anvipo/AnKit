//
//  UIImageView+ShimmerableViewProtocol.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

extension UIImageView: ShimmerableViewProtocol {
	public func showShimmer() {
		removeShimmer()
		addDefaultShimmer()
		layoutShimmer()
	}

	public func hideShimmer() {
		removeShimmer()
	}

	public func layoutShimmer() {
		layoutShimmer(by: bounds)
	}

	public func layoutShimmer(by rect: CGRect) {
		guard let shimmerLayer = shimmerLayer else {
			return
		}

		shimmerLayer.frame = rect
	}
}
