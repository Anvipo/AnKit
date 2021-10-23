//
//  SecondarySystemGroupedBackgroundDecorationItem.swift
//  AnKit
//
//  Created by Anvipo on 26.09.2021.
//

/// Item, which is backed to the section.
public final class SecondarySystemGroupedBackgroundDecorationItem: PlainListBackgroundDecorationItem {
	override public var decorationViewType: CollectionViewDecorationView.Type {
		SecondarySystemGroupedBackgroundDecorationView.self
	}
}
