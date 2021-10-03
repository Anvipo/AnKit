//
//  CurrentResponderProviderProtocol.swift
//  AnKit
//
//  Created by Anvipo on 11.09.2021.
//

import UIKit

/// Protocol for subject, which could provide current responder.
public protocol CurrentResponderProviderProtocol {
	/// Provides current responder.
	var currentResponder: UIResponder? { get }
}
