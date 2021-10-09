//
//  ImageContent.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

/// Enumeration for image content types.
public enum ImageContent {
	/// Content will be provided by remote provider.
	case remoteURL(URLProvider)

	/// Content will be provided by local provider.
	case localImage(UIImageProvider)
}

extension ImageContent {
	var remoteURL: URL? {
		guard case let .remoteURL(urlProvider) = self else {
			return nil
		}

		return urlProvider.url
	}

	var uiImage: UIImage? {
		guard case let .localImage(uiImageProvider) = self else {
			return nil
		}

		return uiImageProvider.uiImage
	}
}

extension ImageContent: Equatable {
	public static func == (lhs: ImageContent, rhs: ImageContent) -> Bool {
		switch (lhs, rhs) {
		case let (.remoteURL(lhs), .remoteURL(rhs)):
			return lhs.url == rhs.url

		case let (.localImage(lhs), .localImage(rhs)):
			return lhs.uiImage == rhs.uiImage

		default:
			return false
		}
	}
}

extension ImageContent: Hashable {
	public func hash(into hasher: inout Hasher) {
		switch self {
		case let .remoteURL(urlProvider):
			hasher.combine(urlProvider.url)

		case let .localImage(uiImageProvider):
			hasher.combine(uiImageProvider.uiImage)
		}
	}
}
