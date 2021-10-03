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
	}
}

extension ImageProvider.ProcessingError: LocalizedError {}
