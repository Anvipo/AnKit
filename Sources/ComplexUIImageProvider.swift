//
//  ComplexUIImageProvider.swift
//  AnKit
//
//  Created by Anvipo on 17.10.2021.
//

import UIKit

/// Complex provider of UIImage.
public struct ComplexUIImageProvider {
	/// Original image provider.
	public let originalUIImageProvider: UIImageProvider

	/// Modifiers, which will be applied to image.
	public let modifiers: [Modifier]

	/// Initializes with specified parameters.
	/// - Parameters:
	///   - originalUIImageProvider: Original image provider.
	///   - modifiers: Modifiers, which will be applied to image.
	public init(
		originalUIImageProvider: UIImageProvider,
		modifiers: [Modifier]
	) throws {
		for modifier in modifiers {
			switch modifier {
			case .tintColored:
				break

			case let .proportionallyResized(targetSize):
				if targetSize.hasAtLeastOneZeroSide {
					throw CGSize.ProportionallySizingError.hasAtLeastOneZeroSide
				}
			}
		}
		self.originalUIImageProvider = originalUIImageProvider
		self.modifiers = modifiers
	}
}

extension ComplexUIImageProvider: UIImageProvider {
	public var uiImage: UIImage {
		var result = originalUIImageProvider.uiImage

		for modifier in modifiers {
			switch modifier {
			case let .tintColored(color):
				result = result.withTintColor(color, renderingMode: .alwaysOriginal)

			case let .proportionallyResized(targetSize):
				// swiftlint:disable:next force_try
				result = try! result.proportionallyRedraw(to: targetSize)
			}
		}

		return result
	}
}
