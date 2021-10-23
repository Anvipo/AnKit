//
//  AnyNSCollectionLayoutEnvironment.swift
//  AnKit
//
//  Created by Anvipo on 23.10.2021.
//

import UIKit

/// Type-erased NSCollectionLayoutEnvironment value.
public final class AnyNSCollectionLayoutEnvironment: NSObject {
	/// Information about the layout's container and environment traits, such as size classes and display scale factor.
	public let base: NSCollectionLayoutEnvironment

	override public var hash: Int {
		AnyNSCollectionLayoutContainer(container).hashValue ^
		traitCollection.hashValue
	}

	/// Creates a type-erased NSCollectionLayoutEnvironment value that wraps the given instance.
	///
	/// - Parameter base: A NSCollectionLayoutEnvironment value to wrap.
	public init(_ base: NSCollectionLayoutEnvironment) {
		self.base = base
	}

	override public func isEqual(_ object: Any?) -> Bool {
		guard let other = object as? AnyNSCollectionLayoutEnvironment else {
			return false
		}

		return self == other
	}
}

extension AnyNSCollectionLayoutEnvironment: NSCollectionLayoutEnvironment {
	public var container: NSCollectionLayoutContainer {
		base.container
	}

	public var traitCollection: UITraitCollection {
		base.traitCollection
	}
}

extension AnyNSCollectionLayoutEnvironment {
	static func == (
		lhs: AnyNSCollectionLayoutEnvironment,
		rhs: AnyNSCollectionLayoutEnvironment
	) -> Bool {
		AnyNSCollectionLayoutContainer(lhs.container) == AnyNSCollectionLayoutContainer(rhs.container) &&
		lhs.traitCollection == rhs.traitCollection
	}
}
