//
//  SecondarySystemGroupedBackgroundDecorationView.swift
//  AnKit
//
//  Created by Anvipo on 26.09.2021.
//

import UIKit

final class SecondarySystemGroupedBackgroundDecorationView: CollectionViewSupplementaryView {
	override init(frame: CGRect) {
		super.init(frame: frame)

		setupUI()
	}
}

private extension SecondarySystemGroupedBackgroundDecorationView {
	func setupUI() {
		backgroundColor = .secondarySystemGroupedBackground

		layer.maskedCorners = .all
		layer.cornerRadius = 16
	}
}
