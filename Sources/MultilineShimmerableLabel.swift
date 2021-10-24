//
//  MultilineShimmerableLabel.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import UIKit

/// Label, which supports multiline shimmers.
public final class MultilineShimmerableLabel: UIView {
	private let label: UILabel
	private let shimmeredView: UIView
	// swiftlint:disable discouraged_optional_collection
	private var labelConstraints: [NSLayoutConstraint]?
	private var shimmeredViewConstraints: [NSLayoutConstraint]?
	// swiftlint:enable discouraged_optional_collection
	private var shimmeredViewHeightConstraint: NSLayoutConstraint?

	/// Spacing between shimmers.
	public var shimmeredLineSpacing: CGFloat {
		didSet {
			layoutShimmer()
		}
	}

	/// Number of shimmers.
	public var numberOfShimmeredLines: Int {
		didSet {
			addDefaultShimmers()
			layoutShimmer()
		}
	}

	override public init(frame: CGRect) {
		label = UILabel()
		shimmeredView = UIView()

		numberOfShimmeredLines = 1
		shimmeredLineSpacing = 10

		super.init(frame: frame)

		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override public func layoutSubviews() {
		super.layoutSubviews()
		layoutShimmer()
	}
}

extension MultilineShimmerableLabel: ShimmerableViewProtocol {
	public func showShimmer() {
		label.isHidden = true
		if let labelConstraints = labelConstraints {
			NSLayoutConstraint.deactivate(labelConstraints)
		}

		shimmeredView.isHidden = false
		shimmeredViewHeightConstraint?.isActive = true

		if let shimmeredViewConstraints = shimmeredViewConstraints {
			NSLayoutConstraint.activate(shimmeredViewConstraints)
		}

		addDefaultShimmers()
		layoutShimmer()
	}

	public func hideShimmer() {
		shimmeredView.isHidden = true
		shimmeredViewHeightConstraint?.isActive = false
		if let shimmeredViewConstraints = shimmeredViewConstraints {
			NSLayoutConstraint.deactivate(shimmeredViewConstraints)
		}

		label.isHidden = false
		if let labelConstraints = labelConstraints {
			NSLayoutConstraint.activate(labelConstraints)
		}
	}

	public func layoutShimmer() {
		layoutShimmer(by: bounds)
	}

	public func layoutShimmer(by rect: CGRect) {
		let shimmerLayers = shimmeredView.shimmerLayers
		if shimmerLayers.isEmpty {
			return
		}

		shimmeredViewHeightConstraint?.isActive = false
		let constant = (label.font.lineHeight * CGFloat(shimmerLayers.count)) +
			(shimmeredLineSpacing * CGFloat(shimmerLayers.count - 1))
		shimmeredViewHeightConstraint = shimmeredView.heightAnchor.constraint(equalToConstant: constant)
		shimmeredViewHeightConstraint?.isActive = true

		let width: CGFloat
		if rect.width != .zero {
			width = bounds.width
		} else if let superview = superview,
				  superview.bounds.width != .zero {
			width = superview.bounds.width
		} else {
			width = UIScreen.main.bounds.width
		}

		for (index, shimmerLayer) in shimmerLayers.enumerated() {
			shimmerLayer.frame = CGRect(
				x: rect.origin.x,
				y: (label.font.lineHeight + shimmeredLineSpacing) * CGFloat(index),
				width: width,
				height: label.font.lineHeight
			)
			shimmerLayer.addDefaultCircleCorners()
		}
	}
}

public extension MultilineShimmerableLabel {
	/// The maximum number of lines for rendering text.
	var numberOfLines: Int {
		get {
			label.numberOfLines
		}
		set {
			label.numberOfLines = newValue
		}
	}

	/// The styled text that the label displays.
	var attributedText: NSAttributedString? {
		get {
			label.attributedText
		}
		set {
			label.attributedText = newValue
		}
	}

	/// The text that the label displays.
	var text: String? {
		get {
			label.text
		}
		set {
			label.text = newValue
		}
	}

	/// The technique for aligning the text.
	var textAlignment: NSTextAlignment {
		get {
			label.textAlignment
		}
		set {
			label.textAlignment = newValue
		}
	}

	/// The font of the text.
	var font: UIFont {
		get {
			label.font
		}
		set {
			label.font = newValue
			layoutShimmer()
		}
	}

	/// The color of the text.
	var textColor: UIColor {
		get {
			label.textColor
		}
		set {
			label.textColor = newValue
		}
	}

	/// Calculates number of lines, which label's text will lay out.
	/// - Parameters:
	///   - width: Available width for label.
	///   - maximumNumberOfLines: The maximum number of lines that the text container can store.
	///   - lineFragmentPadding: The value for the text inset within line fragment rectangles.
	func actualNumberOfLines(
		width: CGFloat,
		maximumNumberOfLines: Int = .zero,
		lineFragmentPadding: CGFloat = .zero
	) -> Int {
		label.actualNumberOfLines(
			width: width,
			maximumNumberOfLines: maximumNumberOfLines,
			lineFragmentPadding: lineFragmentPadding
		)
	}
}

private extension MultilineShimmerableLabel {
	func setupUI() {
		for subview in [shimmeredView, label] {
			addSubview(subview)
			subview.translatesAutoresizingMaskIntoConstraints = false
		}

		labelConstraints = [
			label.topAnchor.constraint(equalTo: topAnchor),
			label.leadingAnchor.constraint(equalTo: leadingAnchor),
			label.trailingAnchor.constraint(equalTo: trailingAnchor),
			label.bottomAnchor.constraint(equalTo: bottomAnchor)
		]

		let shimmeredViewBottomConstraint = shimmeredView.bottomAnchor.constraint(equalTo: bottomAnchor)
		shimmeredViewBottomConstraint.priority = .defaultLow

		shimmeredViewConstraints = [
			shimmeredView.topAnchor.constraint(equalTo: topAnchor),
			shimmeredView.leadingAnchor.constraint(equalTo: leadingAnchor),
			shimmeredView.trailingAnchor.constraint(equalTo: trailingAnchor),
			shimmeredViewBottomConstraint
		]
	}

	func addDefaultShimmers() {
		shimmeredView.shimmerLayers.forEach { $0.removeFromSuperlayer() }

		for _ in 0..<numberOfShimmeredLines {
			shimmeredView.layer.addSublayer(CAGradientLayer.defaultShimmerLayer)
		}
	}
}
