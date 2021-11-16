//
//  ButtonsView.swift
//  AnKit
//
//  Created by Anvipo on 05.11.2021.
//

import UIKit

/// Container view for `Button`s.
public final class ButtonsView: UIView {
	private let buttonsStackView: UIStackView
	private let blurredView: BlurredView

	/// Buttons in container.
	///
	/// Always not empty.
	public let buttons: [Button]

	/// Initializes with specified `buttons`.
	/// - Parameter buttons: Array of buttons, which will be in container. Should not be empty.
	public init(buttons: [Button]) throws {
		if buttons.isEmpty {
			throw InitError.emptyButtons
		}

		buttonsStackView = UIStackView(arrangedSubviews: buttons)
		blurredView = BlurredView(style: .systemUltraThinMaterial)
		self.buttons = buttons

		super.init(frame: .zero)

		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		buttons.first { $0.point(inside: convert(point, to: $0), with: event) }
	}
}

private extension ButtonsView {
	func setupUI() {
		buttonsStackView.spacing = 16
		buttonsStackView.axis = .vertical
		buttonsStackView.distribution = .equalSpacing
		buttonsStackView.directionalLayoutMargins = .default(verticalInset: 16)
		buttonsStackView.isLayoutMarginsRelativeArrangement = true

		addSubviewForConstraintsUse(blurredView)
		blurredView.addSubviewForConstraintsUse(buttonsStackView)

		NSLayoutConstraint.activate(
			blurredView.makeConstraints(to: self) +
			buttonsStackView.makeConstraints(to: blurredView)
		)
	}
}
