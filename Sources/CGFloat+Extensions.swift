//
//  CGFloat+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import CoreGraphics

public extension CGFloat {
	/// Default horizontal offset.
	static let defaultHorizontalOffset: Self = 16

	/// Value's percentage in specified `range`.
	/// - Parameter range: Range, which will be used for calculations.
	func percentage(in range: ClosedRange<Self>) throws -> Self {
		if range.lowerBound >= range.upperBound {
			throw PercentageCalculatingError.invalidRange
		}

		if !range.contains(self) {
			throw PercentageCalculatingError.rangeDoesNotContainSelf
		}

		return (self - range.lowerBound) / (range.upperBound - range.lowerBound)
	}

	/// Reversed value's percentage in specified `range`.
	/// - Parameter range: Range, which will be used for calculations.
	func reversedPercentage(in range: ClosedRange<Self>) throws -> Self {
		let percentage = try percentage(in: range)

		return 1 - percentage
	}
}

public extension Array where Element == CGFloat {
	/// Returns sum of elements in array.
	var sum: Element {
		reduce(.zero, +)
	}

	/// Returns average value of elements in array.
	var average: Element {
		sum / Element(count)
	}
}
