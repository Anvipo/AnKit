//
//  MainTabBarController.swift
//  AnKitPlayground
//
//  Created by Anvipo on 29.11.2021.
//

import UIKit

final class MainTabBarController: UITabBarController {
	private let didChangeTapFeedbackGenerator: UIImpactFeedbackGenerator

	init() {
		didChangeTapFeedbackGenerator = UIImpactFeedbackGenerator(style: .didChangeScreen)

		super.init(nibName: nil, bundle: nil)

		didChangeTapFeedbackGenerator.prepare()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		didChangeTapFeedbackGenerator.prepare()
		didChangeTapFeedbackGenerator.impactOccurred()
		didChangeTapFeedbackGenerator.prepare()
	}
}
