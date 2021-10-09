//
//  CACornerMask+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import QuartzCore

public extension CACornerMask {
	/// Provides mask for all corners.
	static var all: CACornerMask {
		[
			.layerMinXMinYCorner,
			.layerMinXMaxYCorner,
			.layerMaxXMinYCorner,
			.layerMaxXMaxYCorner
		]
	}
}

extension CACornerMask: CaseIterable {
	public typealias AllCases = [Self]

	public static var allCases: AllCases {
		[
			.layerMinXMinYCorner,
			.layerMinXMaxYCorner,
			.layerMaxXMinYCorner,
			.layerMaxXMaxYCorner
		]
	}
}

extension CACornerMask: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(rawValue)
	}
}
