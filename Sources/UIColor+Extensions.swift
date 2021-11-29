//
//  UIColor+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 13.11.2021.
//

import UIKit

public extension UIColor {
	/// Makes color lighter by specified `percentage`.
	/// - Parameter percentage: Value in (0...1) range.
	func lighter(by percentage: CGFloat) throws -> UIColor {
		try adjust(by: percentage)
	}

	/// Makes color darker by specified `percentage`.
	/// - Parameter percentage: Value in (0...1) range.
	func darker(by percentage: CGFloat) throws -> UIColor {
		try adjust(by: -percentage)
	}
}

private extension UIColor {
	func adjust(by percentage: CGFloat) throws -> UIColor {
		if !(0...1).contains(abs(percentage)) {
			throw AdjustError.invalidPercentage
		}

		var alpha, hue, saturation, brightness, red, green, blue, white: CGFloat
		(alpha, hue, saturation, brightness, red, green, blue, white) = (0, 0, 0, 0, 0, 0, 0, 0)

		if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
			let newBrightness = max(min(brightness + percentage * brightness, 1), 0)

			return UIColor(
				hue: hue,
				saturation: saturation,
				brightness: newBrightness,
				alpha: alpha
			)
		}

		if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
			let newRed = min(max(red + percentage * red, 0), 1)
			let newGreen = min(max(green + percentage * green, 0), 1)
			let newBlue = min(max(blue + percentage * blue, 0), 1)

			return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
		}

		if getWhite(&white, alpha: &alpha) {
			let newWhite = (white + percentage * white)

			return UIColor(white: newWhite, alpha: alpha)
		}

		throw AdjustError.unknownColorComponents
	}
}
