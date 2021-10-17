//
//  Font.swift
//  AnKitPlayground
//
//  Created by Anvipo on 17.10.2021.
//

import UIKit

enum Font {
	case title1
	case title2
	case headline
	case subheadline
	case body
	case callout
	case footnote
}

extension Font {
	var uiFont: UIFont {
		switch self {
		case .title1:
			return .preferredFont(forTextStyle: .title1)

		case .title2:
			return .preferredFont(forTextStyle: .title2)

		case .headline:
			return .preferredFont(forTextStyle: .headline)

		case .subheadline:
			return .preferredFont(forTextStyle: .subheadline)

		case .body:
			return .preferredFont(forTextStyle: .body)

		case .callout:
			return .preferredFont(forTextStyle: .callout)

		case .footnote:
			return .preferredFont(forTextStyle: .footnote)
		}
	}
}
