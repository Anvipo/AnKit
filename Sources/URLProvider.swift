//
//  URLProvider.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import Foundation

/// Protocol for URL provider.
public protocol URLProvider {
	/// Internal URL.
	var url: URL { get }
}

extension URL: URLProvider {
	public var url: URL {
		self
	}
}
