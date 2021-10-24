//
//  CGFloat.PercentageCalculatingError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import CoreGraphics
import Foundation

public extension CGFloat {
	/// Error, which could occure in proportionally sizing.
	enum PercentageCalculatingError {
		/// Range is invalid (lower bound is greater than upper bound).
		case invalidRange

		/// Range does not contain self.
		case rangeDoesNotContainSelf
	}
}

extension CGFloat.PercentageCalculatingError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .invalidRange:
			return "Range is invalid. Lower bound is greater than upper bound"

		case .rangeDoesNotContainSelf:
			return "Range does not contain self"
		}
	}
}
