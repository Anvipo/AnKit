//
//  DividerModel.swift
//  AnKit
//
//  Created by Anvipo on 05.09.2021.
//

import UIKit

/// Model, which describes divider parameters.
public struct DividerModel {
	/// The inset distances for divider.
	public let insets: NSDirectionalEdgeInsets

	/// Specifies the line width of the divider.
	public let thickness: CGFloat

	/// The dash pattern applied to the divider’s path when stroked.
	public let dashPattern: [Int]

	/// The color used to stroke the divider’s path.
	public let color: UIColor
}

public extension DividerModel {
	/// The default color used to stroke the divider’s path.
	static var defaultColor: UIColor {
		.separator
	}

	/// Line with big offset from start.
	/// - Parameter color: The color used to stroke the divider’s path.
	static func lineBigOffsetFromStart(
		color: UIColor = Self.defaultColor
	) -> Self {
		Self(
			insets: bigInsets,
			thickness: defaultThickness,
			dashPattern: dashPatternForLineSeparator,
			color: color
		)
	}

	/// Line with default offset from start.
	/// - Parameter color: The color used to stroke the divider’s path.
	static func lineDefaultOffsetFromStart(
		color: UIColor = Self.defaultColor
	) -> Self {
		Self(
			insets: defaultInsets,
			thickness: defaultThickness,
			dashPattern: dashPatternForLineSeparator,
			color: color
		)
	}

	/// Full-width line.
	/// - Parameter color: The color used to stroke the divider’s path.
	static func lineFullWidth(
		color: UIColor = Self.defaultColor
	) -> Self {
		Self(
			insets: .zero,
			thickness: defaultThickness,
			dashPattern: dashPatternForLineSeparator,
			color: color
		)
	}

	/// Dots with big offset from start.
	/// - Parameter color: The color used to stroke the divider’s path.
	static func dottedBigOffsetFromStart(
		color: UIColor = Self.defaultColor
	) -> Self {
		Self(
			insets: bigInsets,
			thickness: defaultThickness,
			dashPattern: dashPatternForDottedSeparator,
			color: color
		)
	}

	/// Dots with default offset from start.
	/// - Parameter color: The color used to stroke the divider’s path.
	static func dottedDefaultOffsetFromStart(
		color: UIColor = Self.defaultColor
	) -> Self {
		Self(
			insets: defaultInsets,
			thickness: defaultThickness,
			dashPattern: dashPatternForDottedSeparator,
			color: color
		)
	}

	/// Full-width dots.
	/// - Parameter color: The color used to stroke the divider’s path.
	static func dottedFullWidth(
		color: UIColor = Self.defaultColor
	) -> Self {
		Self(
			insets: .zero,
			thickness: defaultThickness,
			dashPattern: dashPatternForDottedSeparator,
			color: color
		)
	}

	/// Creates copy of self with specified `color`.
	/// - Parameter color: The color used to stroke the divider’s path.
	func copy(color: UIColor) -> Self {
		Self(
			insets: insets,
			thickness: thickness,
			dashPattern: dashPattern,
			color: color
		)
	}
}

extension DividerModel: Equatable {}

extension DividerModel: Hashable {}

private extension DividerModel {
	static var bigInsets: NSDirectionalEdgeInsets {
		NSDirectionalEdgeInsets(
			top: .zero,
			leading: 64,
			bottom: .zero,
			trailing: .zero
		)
	}

	static var defaultInsets: NSDirectionalEdgeInsets {
		NSDirectionalEdgeInsets(
			top: .zero,
			leading: .defaultHorizontalOffset,
			bottom: .zero,
			trailing: .zero
		)
	}

	static var defaultThickness: CGFloat {
		0.33
	}

	static var dashPatternForLineSeparator: [Int] {
		[1, 0]
	}

	static var dashPatternForDottedSeparator: [Int] {
		[1, 4]
	}
}
