//
//  CABasicAnimation+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import QuartzCore

extension CABasicAnimation {
	static let shimmerAnimationKeyPath = #keyPath(CAGradientLayer.locations)

	static var shimmerAnimation: CABasicAnimation {
		let animation = CABasicAnimation(keyPath: shimmerAnimationKeyPath)
		animation.fromValue = [-1, -0.5, .zero]
		animation.toValue = [1, 1.5, 2]
		animation.repeatCount = .infinity
		animation.duration = 2
		animation.isRemovedOnCompletion = false
		return animation
	}
}
