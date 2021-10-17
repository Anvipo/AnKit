//
//  CAGradientLayer+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import QuartzCore
import UIKit

extension CAGradientLayer {
	static var defaultShimmerLayer: CAGradientLayer {
		let gradientLayer = CAGradientLayer()
		gradientLayer.name = defaultShimmerLayerName

		gradientLayer.startPoint = CGPoint(x: .zero, y: 1)
		gradientLayer.endPoint = CGPoint(x: 1, y: 1)
		gradientLayer.colors = [
			UIColor.systemFill.cgColor,
			UIColor.quaternarySystemFill.cgColor,
			UIColor.systemFill.cgColor
		]
		gradientLayer.locations = [0, 0.5, 1]

		let animation = CABasicAnimation.shimmerAnimation
		gradientLayer.add(animation, forKey: animation.keyPath)

		return gradientLayer
	}
}

extension CALayer {
	var isDefaultShimmerLayer: Bool {
		self is CAGradientLayer &&
		name == CAGradientLayer.defaultShimmerLayerName
	}
}

private extension CAGradientLayer {
	static let defaultShimmerLayerName = "AnKit.defaultShimmerLayer"
}
