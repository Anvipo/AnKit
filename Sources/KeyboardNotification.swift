//
//  KeyboardNotification.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

/// DTO for keyboard notifications.
public struct KeyboardNotification {
	/// Constant that defines how the keyboard will be animated onto or off the screen.
	public let animationCurve: UIView.AnimationCurve

	/// Identifies the duration of the animation in seconds.
	public let animationDuration: TimeInterval

	/// Identifies the starting frame rectangle of the keyboard in screen coordinates.
	/// The frame rectangle reflects the current orientation of the device.
	public let frameBegin: CGRect

	/// Identifies the ending frame rectangle of the keyboard in screen coordinates.
	/// The frame rectangle reflects the current orientation of the device.
	public let frameEnd: CGRect

	/// Identifies whether the keyboard belongs to the current app.
	/// With multitasking on iPad, all visible apps are notified when the keyboard appears and disappears.
	/// The value of this key is true for the app that caused the keyboard to appear and false for any other apps.
	public let isLocal: Bool
}

extension KeyboardNotification {
	init(notification: Notification) throws {
		if notification.name != UIResponder.keyboardWillShowNotification &&
		   notification.name != UIResponder.keyboardDidShowNotification &&
		   notification.name != UIResponder.keyboardWillHideNotification &&
		   notification.name != UIResponder.keyboardDidHideNotification {
			throw MapFromNotificationError.notKeyboardNotification(notification)
		}

		guard var userInfo = notification.userInfo else {
			throw MapFromNotificationError.nilUserInfo(notification)
		}

		if userInfo.isEmpty {
			throw MapFromNotificationError.emptyUserInfo(notification)
		}

		guard let animationCurve = (userInfo.removeValue(forKey: UIResponder.keyboardAnimationCurveUserInfoKey) as? Int)
				.flatMap(UIView.AnimationCurve.init(rawValue:)),
			  let animationDuration = userInfo.removeValue(forKey: UIResponder.keyboardAnimationDurationUserInfoKey) as? TimeInterval,
			  let frameBegin = userInfo.removeValue(forKey: UIResponder.keyboardFrameBeginUserInfoKey) as? CGRect,
			  let frameEnd = userInfo.removeValue(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? CGRect,
			  let isLocal = userInfo.removeValue(forKey: UIResponder.keyboardIsLocalUserInfoKey) as? Bool
		else {
			throw MapFromNotificationError.wrongTypeInUserInfo(notification)
		}

		self.init(
			animationCurve: animationCurve,
			animationDuration: animationDuration,
			frameBegin: frameBegin,
			frameEnd: frameEnd,
			isLocal: isLocal
		)
	}
}
