//
//  CircleButton.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import UIKit

/// Button, which has circle frame.
open class CircleButton: Button {
	private var heightConstraint: NSLayoutConstraint?

	/// Side size of button.
	public final var side: CGFloat {
		didSet {
			heightConstraint?.constant = side
		}
	}

	/// Initializes button with specified `size`.
	/// - Parameter side: Side size of button.
	public init(side: CGFloat) {
		self.side = side

		super.init()

		setupUI()
	}

	override open func layoutSubviews() {
		super.layoutSubviews()
		addDefaultCircleCorners()
	}
}

private extension CircleButton {
	func setupUI() {
		setContentHuggingPriority(.required, for: .horizontal)
		setContentHuggingPriority(.required, for: .vertical)

		let heightConstraint = heightAnchor.constraint(equalToConstant: side)
		self.heightConstraint = heightConstraint

		NSLayoutConstraint.activate([
			widthAnchor.constraint(equalTo: heightAnchor),
			heightConstraint
		])
	}
}
