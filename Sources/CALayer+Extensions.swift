//
//  CALayer+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import QuartzCore

public extension CALayer {
	/// Applies specified `shadowParameters`.
	/// - Parameter shadowParameters: Parameters for setup shadow.
	func apply(
		shadowParameters: ShadowParameters
	) {
		if shadowParameters.animationDuration.isZero {
			shadowColor = shadowParameters.color
			shadowOffset = shadowParameters.offset
			shadowOpacity = shadowParameters.opacity
			shadowPath = shadowParameters.path
			shadowRadius = shadowParameters.radius
		} else {
			animate(keyPath: \.shadowColor, to: shadowParameters.color, duration: shadowParameters.animationDuration)
			animate(keyPath: \.shadowOffset, to: shadowParameters.offset, duration: shadowParameters.animationDuration)
			animate(keyPath: \.shadowOpacity, to: shadowParameters.opacity, duration: shadowParameters.animationDuration)
			animate(keyPath: \.shadowPath, to: shadowParameters.path, duration: shadowParameters.animationDuration)
			animate(keyPath: \.shadowRadius, to: shadowParameters.radius, duration: shadowParameters.animationDuration)
		}
	}

	/// Rounds corners to circle.
	/// - Parameter size: Size of layer.
	func roundCornersToCircle(by size: CGSize) {
		cornerRadius = min(size.width, size.height) / 2
	}

	/// Rounds corners to circle.
	func addDefaultCircleCorners() {
		roundCornersToCircle(by: bounds.size)
	}

	/// Reset corner parameters.
	func resetCornerRadius() {
		masksToBounds = false
		cornerRadius = .zero
	}

	/// Animates specified `keyPath` from current value to specified `value`.
	/// - Parameters:
	///   - keyPath: Key path of value.
	///   - value: Destination value.
	///   - duration: Animation duration.
	func animate<Value>(
		keyPath: WritableKeyPath<CALayer, Value>,
		to value: Value,
		duration: TimeInterval
	) {
		let keyString = NSExpression(forKeyPath: keyPath).keyPath

		let animation = CABasicAnimation(keyPath: keyString)
		animation.fromValue = self[keyPath: keyPath]
		animation.toValue = value
		animation.duration = duration
		add(animation, forKey: animation.keyPath)

		var thelayer = self
		thelayer[keyPath: keyPath] = value
	}
}
