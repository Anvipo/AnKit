//
//  CAGradientLayer+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import QuartzCore

extension CAGradientLayer {
	static let shimmerLayerName = "AnKit.shimmerLayer"

	static var defaultShimmerLayer: CAGradientLayer {
		let gradientLayer = CAGradientLayer()
		gradientLayer.name = shimmerLayerName

		gradientLayer.startPoint = CGPoint(x: .zero, y: 1)
		gradientLayer.endPoint = CGPoint(x: 1, y: 1)
		gradientLayer.colors = [
			CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1),
			CGColor(red: 1, green: 1, blue: 1, alpha: 1),
			CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
		]
		gradientLayer.locations = [0, 0.5, 1]

		let animation = CABasicAnimation.shimmerAnimation
		gradientLayer.add(animation, forKey: animation.keyPath)

		return gradientLayer
	}
}
