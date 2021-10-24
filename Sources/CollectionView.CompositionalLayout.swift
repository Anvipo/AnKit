//
//  CollectionView.CompositionalLayout.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

extension CollectionView {
	@MainActor
	final class CompositionalLayout: UICollectionViewCompositionalLayout {
		init(collectionView: CollectionView) {
			// swiftlint:disable:next unowned_variable_capture
			super.init { [unowned collectionView] sectionIndex, layoutEnvironment in
				guard let section = collectionView.sections[safe: sectionIndex] else {
					fatalError("There is no section at index \(sectionIndex)")
				}

				return section.layoutConfiguration(layoutEnvironment: layoutEnvironment)
			}
		}

		@available(*, unavailable)
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
	}
}
