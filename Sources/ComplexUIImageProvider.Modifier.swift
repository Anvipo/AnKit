//
//  ComplexUIImageProvider.Modifier.swift
//  AnKit
//
//  Created by Anvipo on 17.10.2021.
//

import UIKit

public extension ComplexUIImageProvider {
	/// Modifier, which will be applied to image.
	enum Modifier {
		/// Image will be tint colored with specified color.
		case tintColored(UIColor)

		/// Image will be proportionally resized with specified size.
		case proportionallyResized(targetSize: CGSize)
	}
}

extension ComplexUIImageProvider.Modifier: Equatable {}

extension ComplexUIImageProvider.Modifier: Hashable {}
