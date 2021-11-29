//
//  Color.swift
//  AnKitPlayground
//
//  Created by Anvipo on 17.10.2021.
//

import AnKit
import UIKit

enum Color {
	case shadow
	case brand
	case brandHighlighted
	case white

	case systemBackground
	case secondarySystemBackground
	case tertiarySystemBackground

	case label
	case secondaryLabel
	case labelOnBrand
}

extension Color {
	var uiColor: UIColor {
		switch self {
		case .shadow:
			return .systemGray

		case .brand:
			return .systemIndigo

		case .brandHighlighted:
			// swiftlint:disable:next force_try
			return try! Color.brand.uiColor.lighter(by: 0.1)

		case .white:
			return .white

		case .systemBackground:
			return .systemBackground

		case .secondarySystemBackground:
			return .secondarySystemBackground

		case .tertiarySystemBackground:
			return .tertiarySystemBackground

		case .label:
			return .label

		case .secondaryLabel:
			return .secondaryLabel

		case .labelOnBrand:
			return .white
		}
	}

	var cgColor: CGColor {
		uiColor.cgColor
	}
}
