//
//  BasePlaygroundVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 05.11.2021.
//

import AnKit
import UIKit

class BasePlaygroundVC: BaseVC {
	var playgroundTitle: String {
		fatalError("Implement this method")
	}

	lazy var collectionView = CollectionView()

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = playgroundTitle
		setupUI()

		do {
			try fillCollectionView()
		} catch {
			assertionFailure(error.localizedDescription)
		}
	}

	// swiftlint:disable:next unavailable_function
	func initialSections() throws -> [CollectionViewSection] {
		fatalError("Implement this method")
	}

	func setupUI() {
		view.addSubviewForConstraintsUse(collectionView)
		NSLayoutConstraint.activate(collectionView.makeConstraints(to: view.safeAreaLayoutGuide))
	}
}

private extension BasePlaygroundVC {
	func fillCollectionView() throws {
		try collectionView.set(
			sections: initialSections(),
			animatingDifferences: shouldAnimateDifferences
		)
	}
}