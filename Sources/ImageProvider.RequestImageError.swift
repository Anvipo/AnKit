//
//  ImageProvider.RequestImageError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import Foundation

extension ImageProvider {
	enum RequestImageError {
		case unknownContentType(ImageContent)
	}
}

extension ImageProvider.RequestImageError: LocalizedError {}
