//
//  ImageDownloader.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import Combine
import Foundation

/// Protocol for image downloader.
public protocol ImageDownloader {
	/// Downloads image from remote by URL.
	/// - Parameter imageRemoteURL: Image remote URL.
	func downloadImage(imageRemoteURL: URL) -> AnyPublisher<Data, Error>
}
