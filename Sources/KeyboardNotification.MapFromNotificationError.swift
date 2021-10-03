//
//  KeyboardNotification.MapFromNotificationError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import Foundation

extension KeyboardNotification {
	enum MapFromNotificationError {
		case notKeyboardNotification(Notification)
		case emptyUserInfo(Notification)
		case wrongTypeInUserInfo(Notification)
	}
}

extension KeyboardNotification.MapFromNotificationError: LocalizedError {}
