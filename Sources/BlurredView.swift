//
//  BlurredView.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import UIKit

/// Blurred view.
public final class BlurredView: UIView {
	private let blurredView: UIVisualEffectView
	private var blurAnimator: UIViewPropertyAnimator?

	/// Initializes with specified `style`.
	/// - Parameter style: The intensity of the blur effect.
	public init(style: UIBlurEffect.Style) {
		blurredView = UIVisualEffectView(
			effect: UIAccessibility.isReduceTransparencyEnabled ? nil : UIBlurEffect(style: style)
		)

		super.init(frame: .zero)

		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		// Pass hits to underlying view
		nil
	}

	deinit {
		blurAnimator?.stopAnimation(true)
	}
}

public extension BlurredView {
	/// Sets specified `style`.
	/// - Parameter style: The intensity of the blur effect.
	func set(style: UIBlurEffect.Style?) {
		if let style = style {
			blurredView.effect = UIAccessibility.isReduceTransparencyEnabled ? nil : UIBlurEffect(style: style)
		} else {
			blurredView.effect = nil
		}
	}

	/// Sets specified  `blurPercentage`.
	/// - Parameter blurPercentage: Percentage of blur effect.
	func set(blurPercentage: CGFloat) throws {
		if !(0...1.0).contains(blurPercentage) {
			throw SetBlurPercentageError.wrongBlurPercentageValue(blurPercentage)
		}

		if UIAccessibility.isReduceTransparencyEnabled {
			return
		}

		guard let blurAnimator = blurAnimator else {
			fatalError("Blur animator should not be nil")
		}

		blurAnimator.fractionComplete = 1 - blurPercentage
	}
}

private extension BlurredView {
	func setupUI() {
		blurAnimator = UIViewPropertyAnimator(
			duration: 1,
			curve: .linear
		) { [weak self] in
			self?.blurredView.effect = nil
		}

		blurAnimator?.pausesOnCompletion = true

		for subview in [blurredView] {
			addSubview(subview)
			subview.translatesAutoresizingMaskIntoConstraints = false
		}

		NSLayoutConstraint.activate([
			blurredView.leadingAnchor.constraint(equalTo: leadingAnchor),
			blurredView.topAnchor.constraint(equalTo: topAnchor),
			blurredView.trailingAnchor.constraint(equalTo: trailingAnchor),
			blurredView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}
