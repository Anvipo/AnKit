//
//  CGPoint+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import CoreGraphics

public extension CGPoint {
	/// Calculates distance to specified `point`.
	/// - Parameter point: Point, which will be used for calculations
	func distance(to point: CGPoint) -> CGFloat {
		let distX = point.x - x
		let distY = point.y - y

		return sqrt(distX * distX + distY * distY)
	}
}
