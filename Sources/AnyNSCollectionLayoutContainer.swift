//
//  AnyNSCollectionLayoutContainer.swift
//  AnKit
//
//  Created by Anvipo on 23.10.2021.
//

import UIKit

/// Type-erased NSCollectionLayoutContainer value.
public final class AnyNSCollectionLayoutContainer: NSObject {
	/// Information about the size and content insets of a layout's container.
	public let base: NSCollectionLayoutContainer

	override public var hash: Int {
		contentSize.hashValue ^
		effectiveContentSize.hashValue ^
		contentInsets.hashValue ^
		effectiveContentInsets.hashValue
	}

	/// Creates a type-erased NSCollectionLayoutContainer value that wraps the given instance.
	///
	/// - Parameter base: A NSCollectionLayoutContainer value to wrap.
	public init(_ base: NSCollectionLayoutContainer) {
		self.base = base
	}

	override public func isEqual(_ object: Any?) -> Bool {
		guard let other = object as? AnyNSCollectionLayoutContainer else {
			return false
		}

		return self == other
	}
}

extension AnyNSCollectionLayoutContainer: NSCollectionLayoutContainer {
	public var contentSize: CGSize {
		base.contentSize
	}

	public var effectiveContentSize: CGSize {
		base.effectiveContentSize
	}

	public var contentInsets: NSDirectionalEdgeInsets {
		base.contentInsets
	}

	public var effectiveContentInsets: NSDirectionalEdgeInsets {
		base.effectiveContentInsets
	}
}

extension AnyNSCollectionLayoutContainer {
	static func == (
		lhs: AnyNSCollectionLayoutContainer,
		rhs: AnyNSCollectionLayoutContainer
	) -> Bool {
		lhs.contentSize == rhs.contentSize &&
		lhs.effectiveContentSize == rhs.effectiveContentSize &&
		lhs.contentInsets == rhs.contentInsets &&
		lhs.effectiveContentInsets == rhs.effectiveContentInsets
	}
}
