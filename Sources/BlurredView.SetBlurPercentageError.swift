//
//  BlurredView.SetBlurPercentageError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import CoreGraphics
import Foundation

public extension BlurredView {
	/// Error, which could occure in setting blur percentage.
	enum SetBlurPercentageError {
		/// Specified `blurPercentage` should be in (0...1).
		case wrongBlurPercentageValue(CGFloat)
	}
}

extension BlurredView.SetBlurPercentageError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .wrongBlurPercentageValue(value):
			return "\(value) should be in (0...1)"
		}
	}
}
