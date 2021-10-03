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

	func makeItem(text: String) -> CollectionViewItem {
		PlainLabelItem(
			text: text,
			textColor: .label,
			textFont: .preferredFont(forTextStyle: .title1),
			tintColor: .systemIndigo,
			textAlignment: .center,
			textInsets: NSDirectionalEdgeInsets(
				horizontalInset: .defaultHorizontalOffset,
				verticalInset: 8
			),
			dividerModel: .lineDefaultOffsetFromStart(color: .systemRed)
		)
	}

	func fillCollectionView() {
		do {
			let section = try PlainListSection(
				items: [
					makeItem(text: "Text 1"),
					makeItem(text: "Text 2"),
					makeItem(text: "Text 3"),
					makeItem(text: "Text 4"),
					makeItem(text: "Text 5")
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
