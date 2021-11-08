//
//  CATransitionType+Extensions.swift
//  AnKitPlayground
//
//  Created by Anvipo on 08.11.2021.
//

import QuartzCore

extension CATransitionType: CaseIterable {
	public typealias AllCases = [CATransitionType]

	public static var allCases: AllCases {
		[
			.fade,
			.moveIn,
			.push,
			.reveal
		]
	}
}
