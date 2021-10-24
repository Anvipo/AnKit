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
		onReceiveNotification: @escaping (Result<KeyboardNotification, KeyboardNotification.MapFromNotificationError>) -> Void
	) -> AnyCancellable {
		keyboardNotificationSubscription(
			notificationName: UIResponder.keyboardWillShowNotification,
			onReceiveNotification: onReceiveNotification
		)
	}

	static func didShowSubscription(
		onReceiveNotification: @escaping (Result<KeyboardNotification, KeyboardNotification.MapFromNotificationError>) -> Void
	) -> AnyCancellable {
		keyboardNotificationSubscription(
			notificationName: UIResponder.keyboardDidShowNotification,
			onReceiveNotification: onReceiveNotification
		)
	}

	static func willHideSubscription(
		onReceiveNotification: @escaping (Result<KeyboardNotification, KeyboardNotification.MapFromNotificationError>) -> Void
	) -> AnyCancellable {
		keyboardNotificationSubscription(
			notificationName: UIResponder.keyboardWillHideNotification,
			onReceiveNotification: onReceiveNotification
		)
	}

	static func didHideSubscription(
		onReceiveNotification: @escaping (Result<KeyboardNotification, KeyboardNotification.MapFromNotificationError>) -> Void
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
		onReceiveNotification: @escaping (Result<KeyboardNotification, KeyboardNotification.MapFromNotificationError>) -> Void
	) -> AnyCancellable {
		notificationCenter
			.publisher(for: notificationName)
			.receive(on: DispatchQueue.main)
			.sink { notification in
				do {
					let keyboardNotification = try KeyboardNotification(notification: notification)
					onReceiveNotification(.success(keyboardNotification))
				} catch let error as KeyboardNotification.MapFromNotificationError {
					onReceiveNotification(.failure(error))
				} catch {
					assertionFailure(error.localizedDescription)
				}
			}
	}
}
