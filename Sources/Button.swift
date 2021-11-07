//
//  Button.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//
// swiftlint:disable function_parameter_count

import UIKit

/// A control that executes your custom code in response to user interactions.
open class Button: UIButton {
	/// Closure, which will be triggerd on user taps.
	public final var onTap: (() -> Void)?

	/// Extended tap area's size.
	public final var extendedTapAreaSize: CGSize?

	/// Extended tap area's size.
	public final var extendedTapAreaRect: CGRect?

	/// Initializes button.
	public init() {
		extendedTapAreaSize = Self.defaultExtendedTapAreaSize

		super.init(frame: .zero)

		setupUI()
	}

	@available(*, unavailable)
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override open func layoutSubviews() {
		super.layoutSubviews()
		layoutShimmer()
	}

	override public final func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		let pointInParent = convert(point, to: superview)

		if let extendedTapAreaRect = extendedTapAreaRect {
			return extendedTapAreaRect.contains(pointInParent)
		}

		guard let extendedTapAreaSize = extendedTapAreaSize else {
			return super.point(inside: point, with: event)
		}

		let originalRect = frame

		let extendedXOrigin: CGFloat
		let extendedWidth: CGFloat
		if originalRect.width >= extendedTapAreaSize.width {
			extendedXOrigin = originalRect.origin.x
			extendedWidth = originalRect.width
		} else {
			extendedXOrigin = originalRect.origin.x - ((extendedTapAreaSize.width - originalRect.width) / 2)
			extendedWidth = extendedTapAreaSize.width
		}

		let extendedYOrigin: CGFloat
		let extendedHeight: CGFloat
		if originalRect.height >= extendedTapAreaSize.height {
			extendedYOrigin = originalRect.origin.y
			extendedHeight = originalRect.height
		} else {
			extendedYOrigin = originalRect.origin.y - ((extendedTapAreaSize.height - originalRect.height) / 2)
			extendedHeight = extendedTapAreaSize.height
		}

		let extendedRect = CGRect(
			x: extendedXOrigin,
			y: extendedYOrigin,
			width: extendedWidth,
			height: extendedHeight
		)

		return extendedRect.contains(pointInParent)
	}
}

public extension Button {
	/// Default extended tap area's size.
	static var defaultExtendedTapAreaSize: CGSize {
		CGSize(
			width: defaultExtendedTapAreaWidth,
			height: defaultExtendedTapAreaHeight
		)
	}

	/// Default extended tap area's height.
	static var defaultExtendedTapAreaHeight: CGFloat {
		44
	}

	/// Default extended tap area's width.
	static var defaultExtendedTapAreaWidth: CGFloat {
		44
	}

	/// Sets specified parameters.
	/// - Parameters:
	///   - text: The text of the button.
	///   - textColor: The color of the text.
	///   - textFont: The font of the text.
	///   - tintColor: The tint color to apply to the button text and image.
	///   - backgroundColor: The view’s background color.
	///   - contentEdgeInsets: The inset or outset margins for the rectangle surrounding all of the button’s content.
	///   - onTap: Closure, which will be triggerd on user taps.
	func setup(
		text: String,
		textColor: UIColor,
		textFont: UIFont,
		tintColor: UIColor,
		backgroundColor: UIColor,
		contentEdgeInsets: UIEdgeInsets,
		onTap: @escaping () -> Void
	) {
		setTitle(text, for: .normal)
		setTitleColor(textColor, for: .normal)
		titleLabel?.font = textFont
		self.tintColor = tintColor
		self.backgroundColor = backgroundColor
		self.contentEdgeInsets = contentEdgeInsets
		self.onTap = onTap
	}
}

extension Button: ShimmerableViewProtocol {
	public func showShimmer() {
		isUserInteractionEnabled = false
		layer.masksToBounds = true

		removeShimmer()
		addDefaultShimmer()
		layoutShimmer()
	}

	public func hideShimmer() {
		isUserInteractionEnabled = true
		layer.masksToBounds = false

		removeShimmer()
	}

	public func layoutShimmer() {
		layoutShimmer(by: bounds)
	}

	public func layoutShimmer(by rect: CGRect) {
		guard let shimmerLayer = shimmerLayer else {
			return
		}

		shimmerLayer.frame = rect
	}
}

private extension Button {
	@objc
	func didTap() {
		onTap?()
	}

	func setupUI() {
		if #available(iOS 14.0, *) {
			addAction(
				UIAction { [weak self] _ in
					self?.didTap()
				},
				for: .touchUpInside
			)
		} else {
			addTarget(self, action: #selector(didTap), for: .touchUpInside)
		}
		setTitleColor(tintColor, for: .normal)
	}
}
