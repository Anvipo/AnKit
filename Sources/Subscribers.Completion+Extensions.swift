//
//  Subscribers.Completion+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import Combine

public extension Subscribers.Completion {
	/// Extracts associated value from failure case, if possible.
	var failure: Failure? {
		guard case let .failure(error) = self else {
			return nil
		}

		return error
	}
}
