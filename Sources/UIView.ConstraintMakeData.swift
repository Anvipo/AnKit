//
//  UIView.ConstraintMakeData.swift
//  AnKit
//
//  Created by Anvipo on 05.09.2021.
//

import UIKit

public extension UIView {
	/// Data to create constraint.
	struct ConstraintMakeData {
		/// The relation between the first attribute and the modified second attribute in a constraint.
		public let relation: NSLayoutConstraint.Relation

		/// The constant added to the multiplied second attribute participating in the constraint.
		public let constant: CGFloat

		/// Initializes data with specified parameters.
		/// - Parameters:
		///   - relation: The relation between the first attribute and the modified second attribute in a constraint.
		///   - constant: The constant added to the multiplied second attribute participating in the constraint.
		public init(
			relation: NSLayoutConstraint.Relation,
			constant: CGFloat
		) {
			self.relation = relation
			self.constant = constant
		}
	}
}

extension UIView.ConstraintMakeData {
	func constraint(
		firstAnchor: NSLayoutXAxisAnchor,
		secondAnchor: NSLayoutXAxisAnchor
	) throws -> NSLayoutConstraint {
		switch relation {
		case .lessThanOrEqual:
			return firstAnchor.constraint(
				lessThanOrEqualTo: secondAnchor,
				constant: constant
			)

		case .equal:
			return firstAnchor.constraint(
				equalTo: secondAnchor,
				constant: constant
			)

		case .greaterThanOrEqual:
			return firstAnchor.constraint(
				greaterThanOrEqualTo: secondAnchor,
				constant: constant
			)

		@unknown default:
			throw MakeConstraintError.unknownRelation(relation)
		}
	}

	func constraint(
		firstAnchor: NSLayoutYAxisAnchor,
		secondAnchor: NSLayoutYAxisAnchor
	) throws -> NSLayoutConstraint {
		switch relation {
		case .lessThanOrEqual:
			return firstAnchor.constraint(
				lessThanOrEqualTo: secondAnchor,
				constant: constant
			)

		case .equal:
			return firstAnchor.constraint(
				equalTo: secondAnchor,
				constant: constant
			)

		case .greaterThanOrEqual:
			return firstAnchor.constraint(
				greaterThanOrEqualTo: secondAnchor,
				constant: constant
			)

		@unknown default:
			throw MakeConstraintError.unknownRelation(relation)
		}
	}
}
