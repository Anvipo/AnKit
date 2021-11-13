//
//  UIColor.AdjustError.swift
//  AnKit
//
//  Created by Anvipo on 13.11.2021.
//

import UIKit

public extension UIColor {
	/// Error, which could occure in adjusting color components.
	enum AdjustError {
		/// Specified percentage is invalid.
		case invalidPercentage

		/// Color has unknown color components.
		case unknownColorComponents
	}
}

extension UIColor.AdjustError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .invalidPercentage:
			return "Specified percentage is invalid"

		case .unknownColorComponents:
			return "Color has unknown color components."
		}
	}
}
