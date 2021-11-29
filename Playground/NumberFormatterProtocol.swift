//
//  NumberFormatterProtocol.swift
//  AnKitPlayground
//
//  Created by Anvipo on 07.11.2021.
//

import Foundation

protocol NumberFormatterProtocol {
	func string(from double: Double) -> String?
	func double(from string: String) -> Double?
}

extension NumberFormatter: NumberFormatterProtocol {
	func string(from double: Double) -> String? {
		// swiftlint:disable:next legacy_objc_type
		string(from: double as NSNumber)
	}

	func double(from string: String) -> Double? {
		nsNumber(from: string)?.doubleValue
	}
}

private extension NumberFormatter {
	// swiftlint:disable:next legacy_objc_type
	func nsNumber(from string: String) -> NSNumber? {
		if string.isEmpty {
			return nil
		}

		let clearedString = string
			.replacingOccurrences(of: locale.groupingSeparator ?? "", with: "")
			.trimmingCharacters(in: .whitespacesAndNewlines)

		if clearedString.isEmpty {
			return nil
		}

		return number(from: clearedString)
	}
}
