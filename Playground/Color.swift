//
//  Color.swift
//  AnKitPlayground
//
//  Created by Anvipo on 17.10.2021.
//

import UIKit

enum Color {
	case shadow
	case brand
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
			return .systemGray5

		case .brand:
			return .systemIndigo

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
