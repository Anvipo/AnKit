//
//  TappableView.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import UIKit

/// View, which could handle tap in extended area.
open class TappableView: UIView {
	/// Extended tap area's size.
	public final var extendedTapAreaSize: CGSize? = CGSize(width: 44, height: 44)

	/// Extended tap area's size.
	public final var extendedTapAreaRect: CGRect?

	override public final func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		let point = convert(point, to: self)

		if let extendedTapAreaRect = extendedTapAreaRect {
			return extendedTapAreaRect.contains(point)
		}

		guard let extendedTapAreaSize = extendedTapAreaSize else {
			return super.point(inside: point, with: event)
		}

		let originalRect = frame

		let extendedXOrigin: CGFloat
		let extendedWidth: CGFloat
		if originalRect.width >= extendedTapAreaSize.width {
			extendedXOrigin = originalRect.origin.x
			extendedWidth = originalRect.width
		} else {
			extendedXOrigin = originalRect.origin.x - ((extendedTapAreaSize.width - originalRect.width) / 2)
			extendedWidth = extendedTapAreaSize.width
		}

		let extendedYOrigin: CGFloat
		let extendedHeight: CGFloat
		if originalRect.height >= extendedTapAreaSize.height {
			extendedYOrigin = originalRect.origin.y
			extendedHeight = originalRect.height
		} else {
			extendedYOrigin = originalRect.origin.y - ((extendedTapAreaSize.height - originalRect.height) / 2)
			extendedHeight = extendedTapAreaSize.height
		}

		let extendedRect = CGRect(
			x: extendedXOrigin,
			y: extendedYOrigin,
			width: extendedWidth,
			height: extendedHeight
		)

		return extendedRect.contains(point)
	}
}
