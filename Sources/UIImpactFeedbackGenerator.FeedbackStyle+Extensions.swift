//
//  UIImpactFeedbackGenerator.FeedbackStyle+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import UIKit

public extension UIImpactFeedbackGenerator.FeedbackStyle {
	/// Style for "Did change screen" feedback.
	static let didChangeScreen: Self = soft

	/// Style for "Did change expanded state" feedback.
	static let didChangeExpandedState: Self = medium
}
