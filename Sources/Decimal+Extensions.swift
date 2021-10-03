//
//  Decimal+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import Foundation

public extension Decimal {
	/// Converts to `Double`.
	var doubleValue: Double {
		// swiftlint:disable:next legacy_objc_type
		(self as NSDecimalNumber).doubleValue
	}

	/// Converts to `Int`.
	var intValue: Int {
		// swiftlint:disable:next legacy_objc_type
		(self as NSDecimalNumber).intValue
	}

	/// Is decimal whole number.
	var isWholeNumber: Bool {
		if isZero {
			return true
		}

		if !isNormal {
			return false
		}

		return exponent >= 0
	}
}
