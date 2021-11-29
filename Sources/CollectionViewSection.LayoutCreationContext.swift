//
//  CollectionViewSection.LayoutCreationContext.swift
//  AnKit
//
//  Created by Anvipo on 08.11.2021.
//

import UIKit

public extension CollectionViewSection {
	/// Detailed information sufficient to create the layout of the section.
	struct LayoutCreationContext {
		/// The index of the section, which is currently creating.
		public let sectionIndex: Int

		/// Information about the current layout environment.
		public let layoutEnvironment: NSCollectionLayoutEnvironment
	}
}
