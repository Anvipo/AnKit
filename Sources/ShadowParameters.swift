//
//  ShadowParameters.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import CoreGraphics
import Foundation

/// Parameters for setup shadows.
public struct ShadowParameters {
	/// The color of the layer’s shadow.
	public let color: CGColor

	/// The offset (in points) of the layer’s shadow.
	public let offset: CGSize

	/// The opacity of the layer’s shadow.
	public let opacity: Float

	/// The shape of the layer’s shadow.
	public let path: CGPath

	/// The blur radius (in points) used to render the layer’s shadow.
	public let radius: CGFloat

	/// Specifies the basic duration of the animation, in seconds.
	public let animationDuration: TimeInterval

	/// Initializes with specified parameters.
	/// - Parameters:
	///   - color: The color of the layer’s shadow.
	///   - offset: The offset (in points) of the layer’s shadow.
	///   - opacity: The opacity of the layer’s shadow.
	///   - path: The shape of the layer’s shadow.
	///   - radius: The blur radius (in points) used to render the layer’s shadow.
	///   - animationDuration: Specifies the basic duration of the animation, in seconds.
	public init(
		color: CGColor,
		offset: CGSize,
		opacity: Float,
		path: CGPath,
		radius: CGFloat,
		animationDuration: TimeInterval
	) {
		self.color = color
		self.offset = offset
		self.opacity = opacity
		self.path = path
		self.radius = radius
		self.animationDuration = animationDuration
	}
}

public extension ShadowParameters {
	/// Provides default shadow parameters.
	/// - Parameters:
	///   - color: The color of the layer’s shadow.
	///   - path: The shape of the layer’s shadow.
	///   - animationDuration: Specifies the basic duration of the animation, in seconds.
	static func `default`(
		color: CGColor,
		path: CGPath,
		animationDuration: TimeInterval
	) -> Self {
		Self(
			color: color,
			offset: CGSize(width: .zero, height: 1),
			opacity: 1,
			path: path,
			radius: 5,
			animationDuration: animationDuration
		)
	}
}
