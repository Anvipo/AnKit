//
//  ButtonsView.InitError.swift
//  AnKit
//
//  Created by Anvipo on 16.11.2021.
//

import Foundation

public extension ButtonsView {
	/// Error, which could occure in `init`.
	enum InitError {
		/// Specified buttons are empty.
		case emptyButtons
	}
}

extension ButtonsView.InitError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .emptyButtons:
			return "Specified buttons are empty"
		}
	}
}
