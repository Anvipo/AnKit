//
//  CornersStyle.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import QuartzCore

/// Style of view corners.
public enum CornersStyle {
	/// Not styled corners.
	case no

	/// Corners styled by specified parameters.
	case specified(cornerRadius: CGFloat, maskedCorners: CACornerMask)

	/// Circle styled corners.
	case circle(maskedCorners: CACornerMask)
}

extension CornersStyle: Equatable {}

extension CornersStyle: Hashable {}
