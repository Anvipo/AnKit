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
	case remoteURL(
		urlProvider: URLProvider,
		imageDownloader: ImageDownloader,
		imageModifiers: [ComplexUIImageProvider.Modifier] = []
	)

	/// Content will be provided by local provider.
	case localImage(uiImageProvider: UIImageProvider)
}

extension ImageContent: Equatable {
	public static func == (lhs: ImageContent, rhs: ImageContent) -> Bool {
		switch (lhs, rhs) {
		case let (
			.remoteURL(lhsURLProvider, _, lhsImageModifiers),
			.remoteURL(rhsURLProvider, _, rhsImageModifiers)
		):
			return lhsURLProvider.url == rhsURLProvider.url &&
			lhsImageModifiers == rhsImageModifiers

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
		case let .remoteURL(urlProvider, _, imageModifiers):
			hasher.combine(urlProvider.url)
			hasher.combine(imageModifiers)

		case let .localImage(uiImageProvider):
			hasher.combine(uiImageProvider.uiImage)
		}
	}
}
