//
//  UIView.ConstraintsMakeData.swift
//  AnKit
//
//  Created by Anvipo on 05.09.2021.
//

import UIKit

public extension UIView {
	/// Data to create constraints.
	struct ConstraintsMakeData {
		/// Data to create leading constraint.
		public let leading: ConstraintMakeData

		/// Data to create top constraint.
		public let top: ConstraintMakeData

		/// Data to create trailing constraint.
		public let trailing: ConstraintMakeData

		/// Data to create bottom constraint.
		public let bottom: ConstraintMakeData

		/// Initializes data with specified parameters.
		/// - Parameters:
		///   - leading: Data to create leading constraint.
		///   - top: Data to create top constraint.
		///   - trailing: Data to create trailing constraint.
		///   - bottom: Data to create bottom constraint.
		public init(
			leading: ConstraintMakeData,
			top: ConstraintMakeData,
			trailing: ConstraintMakeData,
			bottom: ConstraintMakeData
		) {
			self.leading = leading
			self.top = top
			self.trailing = trailing
			self.bottom = bottom
		}
	}
}
