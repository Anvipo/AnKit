//
//  Tappable.swift
//  AnKit
//
//  Created by Anvipo on 08.09.2021.
//

/// Protocol for subjects, which could be tapped.
public protocol Tappable {
	/// Can subject responses to tap.
	var canResponseToTap: Bool { get }

	/// Action, which will be triggered when user taps on subject.
	var onTap: (() -> Void)? { get }
}
