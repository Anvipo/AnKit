//
//  ExpandableTextItem.CellHeightCalculationContext.swift
//  AnKitPlayground
//
//  Created by Anvipo on 07.11.2021.
//

import AnKit

extension ExpandableTextItem {
	struct CellHeightCalculationContext {
		let isExpanded: Bool
		let context: CollectionViewItem.CellHeightCalculationContext
	}
}

extension ExpandableTextItem.CellHeightCalculationContext: Equatable {}

extension ExpandableTextItem.CellHeightCalculationContext: Hashable {}
