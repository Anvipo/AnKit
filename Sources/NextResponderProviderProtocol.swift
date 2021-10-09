//
//  NextResponderProviderProtocol.swift
//  AnKit
//
//  Created by Anvipo on 11.09.2021.
//

import UIKit

/// Protocol for subject, which could provide next responder.
public protocol NextResponderProviderProtocol: AnyObject {
	/// Provides next responder.
	var getNextResponder: (() -> UIResponder?)? { get set }
}
