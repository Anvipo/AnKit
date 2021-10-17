//
//  Image.swift
//  AnKitPlayground
//
//  Created by Anvipo on 17.10.2021.
//

import AnKit
import UIKit

enum Image {
	case star
}

extension Image {
	func complexProvider(
		modifiers: [ComplexUIImageProvider.Modifier]
	) throws -> UIImageProvider {
		try ComplexUIImageProvider(
			originalUIImageProvider: self,
			modifiers: modifiers
		)
	}
}

extension Image: UIImageProvider {
	var uiImage: UIImage {
		// swiftlint:disable force_unwrapping
		switch self {
		case .star:
			return UIImage(systemName: "star")!
		}
		// swiftlint:enable force_unwrapping
	}
}

extension Image: Equatable {}

extension Image: Hashable {}
