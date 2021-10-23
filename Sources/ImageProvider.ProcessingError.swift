//
//  ImageProvider.ProcessingError.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import Foundation

public extension ImageProvider {
	/// Errors, which could occure in image provider.
	enum ProcessingError {
		/// There was network error.
		case networkError(Error)

		/// Did download data, which could not be presented as image.
		case notImageData(Data)

		/// There was image processing error.
		case imageProcessingError(Error)
	}
}

extension ImageProvider.ProcessingError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .networkError(error):
			return "There was network error - \(error)"

		case let .notImageData(data):
			return "Did download data, which could not be presented as image. Data - \(data)"

		case let .imageProcessingError(error):
			return "There was image processing error - \(error)"
		}
	}
}
