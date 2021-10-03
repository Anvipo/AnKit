//
//  UIAlertController+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 12.09.2021.
//

import UIKit

public extension UIAlertController {
	/// Initializes alert controller with specified parameters.
	/// - Parameters:
	///   - alertTitle: The title of the alert.
	///   - alertMessage: Descriptive text that provides more details about the reason for the alert.
	///   - alertActions: The actions that the user can take in response to the alert.
	///   - alertPreferredAction: The preferred action for the user to take from an alert.
	convenience init(
		alertTitle: String?,
		alertMessage: String?,
		alertActions: [UIAlertAction],
		alertPreferredAction: UIAlertAction?
	) {
		self.init(
			title: alertTitle,
			message: alertMessage,
			preferredStyle: .alert
		)

		for alertAction in alertActions {
			addAction(alertAction)
		}

		preferredAction = alertPreferredAction
	}
}
