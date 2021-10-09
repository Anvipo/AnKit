//
//  DividerDefaultStrategy.swift
//  AnKit
//
//  Created by Anvipo on 05.09.2021.
//

/// Default divider strategy, which hide separators in last items in each section.
public struct DividerDefaultStrategy {
	/// Initializes strategy.
	public init() {}
}

extension DividerDefaultStrategy: DividerStrategyProtocol {
	public func separateItems(in sections: [CollectionViewSection]) {
		for section in sections {
			if var dividerableItem = section.items.last as? Dividerable {
				dividerableItem.dividerModel = nil
			}
		}
	}
}
