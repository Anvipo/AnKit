//
//  SceneDelegate.swift
//  AnKitPlayground
//
//  Created by Anvipo on 03.10.2021.
//

import UIKit

final class SceneDelegate: UIResponder {
	private(set) static var sharedWindow: UIWindow?
	var window: UIWindow?
}

extension SceneDelegate: UISceneDelegate {
	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let windowScene = scene as? UIWindowScene else {
			assertionFailure("?")
			return
		}

		let window = UIWindow(windowScene: windowScene)
		self.window = window
		Self.sharedWindow = window
		let navigationController = UINavigationController(rootViewController: MainVC())
		navigationController.navigationBar.tintColor = Color.brand.uiColor
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
	}
}

extension SceneDelegate: UIWindowSceneDelegate {}
