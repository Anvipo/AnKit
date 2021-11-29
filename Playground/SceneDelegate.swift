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

		let tableViewsNC = UINavigationController(rootViewController: TableViewsVC())
		tableViewsNC.navigationBar.tintColor = Color.brand.uiColor
		tableViewsNC.tabBarItem = UITabBarItem(title: "Table views", image: UIImage(systemName: "rectangle.split.1x2"), tag: 0)

		let collectionViewsNC = UINavigationController(rootViewController: CollectionViewsVC())
		collectionViewsNC.navigationBar.tintColor = Color.brand.uiColor
		collectionViewsNC.tabBarItem = UITabBarItem(title: "Collection views", image: UIImage(systemName: "square.grid.3x3"), tag: 0)

		let mainTabBarController = MainTabBarController()
		mainTabBarController.viewControllers = [
			tableViewsNC,
			collectionViewsNC
		]

		window.rootViewController = mainTabBarController
		window.makeKeyAndVisible()
	}
}

extension SceneDelegate: UIWindowSceneDelegate {}
