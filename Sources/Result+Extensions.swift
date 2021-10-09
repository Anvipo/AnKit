//
//  Result+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

public extension Result {
	/// Extracts associated value from success case, if possible.
	var success: Success? {
		guard case let .success(success) = self else {
			return nil
		}

		return success
	}

	/// Extracts associated value from failure case, if possible.
	var failure: Failure? {
		guard case let .failure(failure) = self else {
			return nil
		}

		return failure
	}
}
