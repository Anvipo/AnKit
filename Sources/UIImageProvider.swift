//
//  UIImageProvider.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

/// Protocol for UIImage provider.
public protocol UIImageProvider {
	/// Internal UIImage.
	var uiImage: UIImage { get }
}

extension UIImage: UIImageProvider {
	public var uiImage: UIImage {
		self
	}
}
