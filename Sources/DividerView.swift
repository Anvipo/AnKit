//
//  DividerView.swift
//  AnKit
//
//  Created by Anvipo on 05.09.2021.
//

import UIKit

/// View, which represents divider.
public final class DividerView: UIView {
	private let shapeLayer: CAShapeLayer

	/// Model, which describes divider parameters.
	public var model: DividerModel? {
		didSet {
			updateAppearance()
		}
	}

	override public var intrinsicContentSize: CGSize {
		guard let model = model else {
			return .zero
		}

		return CGSize(width: UIView.noIntrinsicMetric, height: model.thickness)
	}

	/// Initializes divider with specified `model`.
	/// - Parameter model: Model, which describes divider parameters.
	public init(model: DividerModel?) {
		self.model = model
		self.shapeLayer = CAShapeLayer()

		super.init(frame: .zero)

		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override public func layoutSubviews() {
		super.layoutSubviews()
		updateShapeLayer()
	}

	override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		updateAppearance()
	}
}

private extension DividerView {
	func setupUI() {
		layer.addSublayer(shapeLayer)

		updateAppearance()
	}

	func updateAppearance() {
		guard let model = model else {
			return
		}

		shapeLayer.strokeColor = model.color.cgColor

		updateShapeLayer()
	}

	func updateShapeLayer() {
		guard let model = model else {
			shapeLayer.path = nil
			return
		}

		// swiftlint:disable:next legacy_objc_type
		shapeLayer.lineDashPattern = model.dashPattern as [NSNumber]
		shapeLayer.lineWidth = model.thickness

		let path = UIBezierPath()
		path.move(to: CGPoint(x: bounds.width, y: .zero))
		path.addLine(to: CGPoint(x: model.insets.leading, y: .zero))

		shapeLayer.path = path.cgPath
	}
}
