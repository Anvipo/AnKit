//
//  Array+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

public extension Array {
	/// Returns array of unique elements.
	/// - Parameter byElementProperty: Closure, which return property of element, which will be used as unique identifier.
	func unique<T: Hashable>(byElementProperty: (Element) -> T) -> [Element] {
		var propertiesSet = Set<T>()

		var result = [Element]()
		for element in self {
			let checkingProperty = byElementProperty(element)

			if !propertiesSet.contains(checkingProperty) {
				propertiesSet.insert(checkingProperty)
				result.append(element)
			}
		}

		return result
	}

	/// Accesses the element at the specified position, if array contains it.
	/// - Parameter index: The position of the element to access.
	subscript(safe index: Int) -> Element? {
		indices ~= index ? self[index] : nil
	}
}
