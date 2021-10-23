//
//  KeyboardNotification.MapFromNotificationError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import Foundation

public extension KeyboardNotification {
	/// Errors, which could occure in Notification mapping.
	enum MapFromNotificationError {
		/// Received notification is not keyabord-related.
		case notKeyboardNotification(Notification)

		/// Notification's user info is nil.
		case nilUserInfo(Notification)

		/// Notification's user info is empty.
		case emptyUserInfo(Notification)

		/// User info has wrong type in keyboard notification sense.
		case wrongTypeInUserInfo(Notification)
	}
}

extension KeyboardNotification.MapFromNotificationError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .notKeyboardNotification(notification):
			return "Received notification is not keyabord-related. Notification - \(notification)"

		case let .nilUserInfo(notification):
			return "Notification's user info is nil. Notification - \(notification)"

		case let .emptyUserInfo(notification):
			return "Notification's user info is empty. Notification - \(notification)"

		case let .wrongTypeInUserInfo(notification):
			return "User info has wrong type in keyboard notification sense.. Notification - \(notification)"
		}
	}
}
