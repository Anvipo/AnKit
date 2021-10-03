//
//  UIImage+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

public extension UIImage {
	/// Redraws proportionally image to specified `targetSize`.
	/// - Parameter targetSize: Size, which will be used for proportionally resizing.
	func proportionallyRedraw(to targetSize: CGSize) throws -> UIImage {
		let proportionallySize = try size.proportionallySize(basedOn: targetSize)

		return redraw(to: proportionallySize)
	}
}

private extension UIImage {
	/// Redraws image to specified `newSize`.
	/// - Parameter newSize: New size of redrawed image.
	func redraw(to newSize: CGSize) -> UIImage {
		UIGraphicsImageRenderer(size: newSize).image { _ in
			let rect = CGRect(origin: .zero, size: newSize)
			draw(in: rect)
		}
	}
}
