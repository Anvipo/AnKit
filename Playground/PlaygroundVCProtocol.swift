//
//  PlaygroundVCProtocol.swift
//  AnKitPlayground
//
//  Created by Anvipo on 15.11.2021.
//

import UIKit

protocol PlaygroundVCProtocol: UIViewController {
	static var playgroundTitle: String { get }

	init()
}
