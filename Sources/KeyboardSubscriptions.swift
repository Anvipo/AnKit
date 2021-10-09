//
//  KeyboardSubscriptions.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import Combine
import UIKit

enum KeyboardSubscriptions {}

extension KeyboardSubscriptions {
	static func willShowSubscription(
		onReceiveNotification: @escaping (KeyboardNotification) -> Void
	) -> AnyCancellable {
		keyboardNotificationSubscription(
			notificationName: UIResponder.keyboardWillShowNotification,
			onReceiveNotification: onReceiveNotification
		)
	}

	static func didShowSubscription(
		onReceiveNotification: @escaping (KeyboardNotification) -> Void
	) -> AnyCancellable {
		keyboardNotificationSubscription(
			notificationName: UIResponder.keyboardDidShowNotification,
			onReceiveNotification: onReceiveNotification
		)
	}

	static func willHideSubscription(
		onReceiveNotification: @escaping (KeyboardNotification) -> Void
	) -> AnyCancellable {
		keyboardNotificationSubscription(
			notificationName: UIResponder.keyboardWillHideNotification,
			onReceiveNotification: onReceiveNotification
		)
	}

	static func didHideSubscription(
		onReceiveNotification: @escaping (KeyboardNotification) -> Void
	) -> AnyCancellable {
		keyboardNotificationSubscription(
			notificationName: UIResponder.keyboardDidHideNotification,
			onReceiveNotification: onReceiveNotification
		)
	}
}

private extension KeyboardSubscriptions {
	static var notificationCenter: NotificationCenter {
		.default
	}

	static func keyboardNotificationSubscription(
		notificationName: Notification.Name,
		onReceiveNotification: @escaping (KeyboardNotification) -> Void
	) -> AnyCancellable {
		notificationCenter
			.publisher(for: notificationName)
			.receive(on: DispatchQueue.main)
			.sink { notification in
				do {
					let keyboardNotification = try KeyboardNotification(notification: notification)
					onReceiveNotification(keyboardNotification)
				} catch {
					assertionFailure(error.localizedDescription)
				}
			}
	}
}
