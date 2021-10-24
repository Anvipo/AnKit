//
//  SimpleVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 03.10.2021.
//

import AnKit
import UIKit

final class SimpleVC: UIViewController {
	private lazy var collectionView = CollectionView()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		fillCollectionView()
	}
}

private extension SimpleVC {
	func setupUI() {
		navigationItem.title = "Simple screen example"

		view.backgroundColor = .systemBackground

		view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}

	func fillCollectionView() {
		do {
			let section = try PlainListSection(
				items: [
					AnKitPlayground.makePlainLabelItem(text: "Text 1", dividerColor: .systemRed),
					AnKitPlayground.makePlainLabelItem(text: "Text 2", dividerColor: .systemRed),
					AnKitPlayground.makePlainLabelItem(text: "Text 3", dividerColor: .systemRed),
					AnKitPlayground.makePlainLabelItem(text: "Text 4", dividerColor: .systemRed),
					AnKitPlayground.makePlainLabelItem(text: "Text 5", dividerColor: .systemRed)
				]
			)

			try collectionView.set(
				sections: [section],
				animatingDifferences: false
			)
		} catch {
			assertionFailure(error.localizedDescription)
		}
	}
}
