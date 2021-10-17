//
//  CGSize+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import CoreGraphics

public extension CGSize {
	/// Calculates does size have at least one zero side.
	var hasAtLeastOneZeroSide: Bool {
		self == .zero || width == .zero || height == .zero
	}

	/// Makes square by specified `side`.
	/// - Parameter side: Square side.
	static func square(side: CGFloat) -> Self {
		Self(width: side, height: side)
	}

	/// Calculates proportionally size based on specified `targetSize`.
	/// - Parameter targetSize: Target size, which will be used in calculations.
	func proportionallySize(basedOn targetSize: CGSize) throws -> CGSize {
		if hasAtLeastOneZeroSide {
			throw ProportionallySizingError.hasAtLeastOneZeroSide
		}

		let widthRatio = targetSize.width / width
		let heightRatio = targetSize.height / height

		let neededRatio = min(widthRatio, heightRatio)

		return CGSize(width: width * neededRatio, height: height * neededRatio)
	}
}

extension CGSize: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(width)
		hasher.combine(height)
	}
}
