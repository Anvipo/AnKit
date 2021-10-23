//
//  CGSize.ProportionallySizingError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import CoreGraphics
import Foundation

public extension CGSize {
	/// Error, which could occure in proportionally sizing.
	enum ProportionallySizingError {
		/// Size has at least one zero side.
		case hasAtLeastOneZeroSide
	}
}

extension CGSize.ProportionallySizingError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .hasAtLeastOneZeroSide:
			return "Size has at least one zero side"
		}
	}
}
