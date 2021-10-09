//
//  DividerStrategyProtocol.swift
//  AnKit
//
//  Created by Anvipo on 05.09.2021.
//

/// Protocol of strategy, which manages dividers in sections.
public protocol DividerStrategyProtocol {
	/// Analyzes sections and separate items in them.
	/// - Parameter sections: Sections, whose item should be separated.
	func separateItems(in sections: [CollectionViewSection])
}
