//
//  UIView.ConstraintMakeData.MakeConstraintError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import Foundation
import UIKit

public extension UIView.ConstraintMakeData {
	/// Error, which could occure in making constraint.
	enum MakeConstraintError {
		/// Relation is unknown
		case unknownRelation(NSLayoutConstraint.Relation)
	}
}

extension UIView.ConstraintMakeData.MakeConstraintError: LocalizedError {}
