//
//  Double+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

public extension Array where Element == Double {
	/// Returns sum of elements in array.
	var sum: Element {
		reduce(.zero, +)
	}

	/// Returns average value of elements in array.
	var average: Element {
		sum / Element(count)
	}
}
