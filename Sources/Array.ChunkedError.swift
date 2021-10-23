//
//  Array.ChunkedError.swift
//  AnKit
//
//  Created by Anvipo on 23.10.2021.
//

import Foundation

public extension Array {
	/// Error, which could occure in `chunked(into:)`.
	enum ChunkedError {
		/// Specified `size` is not positive.
		case notPositiveSize
	}
}

extension Array.ChunkedError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .notPositiveSize:
			return "Specified size is not positive"
		}
	}
}
