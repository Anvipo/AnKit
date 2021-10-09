//
//  HasImageProviders.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

/// Protocol for subjects who has image providers.
public protocol HasImageProviders {
	/// Image providers in subject.
	var imageProviders: [ImageProvider] { get }
}
