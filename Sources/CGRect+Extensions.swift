//
//  CGRect+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import CoreGraphics

public extension CGRect {
	/// Center point in rect.
	var center: CGPoint {
		CGPoint(x: midX, y: midY)
	}
}
