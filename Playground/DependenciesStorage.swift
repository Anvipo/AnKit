//
//  DependenciesStorage.swift
//  AnKitPlayground
//
//  Created by Anvipo on 07.11.2021.
//

import Foundation

final class DependenciesStorage {
	static let shared = DependenciesStorage()

	let locale: Locale
	let calendar: Calendar
	let numberFormatter: NumberFormatterProtocol

	private init() {
		locale = .autoupdatingCurrent

		var calendar = Calendar.autoupdatingCurrent
		calendar.locale = locale
		self.calendar = calendar

		let numberFormatter = NumberFormatter()
		numberFormatter.locale = locale
		numberFormatter.numberStyle = .decimal
		numberFormatter.generatesDecimalNumbers = true
		self.numberFormatter = numberFormatter
	}
}
