//
//  BaseViewOutput.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

/// Protocol for output subject for a base view.
public protocol BaseViewOutput: AnyObject {
	/// Calls from `viewDidAppear` in base view.
	func baseViewDidAppear()
}
