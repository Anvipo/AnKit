//
//  UIView+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

public extension UIView {
	/// Returns existing shimmer layer in view.
	var shimmerLayer: CALayer? {
		let shimmerLayers = shimmerLayers

		if shimmerLayers.count > 1 {
			fatalError("Remove extra shimmer layers")
		}

		return shimmerLayers.first
	}

	/// Add shimmer with default settings to view.
	func addDefaultShimmer() {
		layer.addSublayer(CAGradientLayer.defaultShimmerLayer)
		shimmerLayer?.cornerRadius = layer.cornerRadius
		shimmerLayer?.maskedCorners = layer.maskedCorners
		shimmerLayer?.masksToBounds = layer.masksToBounds
	}

	/// Removes shimmer from view.
	func removeShimmer() {
		guard let shimmerLayer = shimmerLayer else {
			return
		}

		shimmerLayer.removeFromSuperlayer()
	}

	/// Provides bounds in coordinate space of specified `view`.
	/// - Parameter view: View, whose coordinate space will be used.
	func bounds(inCoordinateSpaceOf view: UIView) -> CGRect {
		convert(bounds, to: view)
	}

	/// Make constraints from `self` to `layoutGuide`.
	/// - Parameters:
	///   - layoutGuide: Layout guide, whose anchors will be used for constraints.
	///   - insets: Insets for constraints.
	func makeConstraints(
		to layoutGuide: UILayoutGuide,
		insets: NSDirectionalEdgeInsets = .zero
	) -> [NSLayoutConstraint] {
		[
			leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: insets.leading),
			topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top),
			trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -insets.trailing),
			bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom)
		]
	}

	/// Make constraints from `self` to `layoutGuide`.
	/// - Parameters:
	///   - layoutGuide: Layout guide, whose anchors will be used for constraints.
	///   - createData: Data to create constraints.
	func makeConstraints(
		to layoutGuide: UILayoutGuide,
		createData: ConstraintsMakeData
	) throws -> [NSLayoutConstraint] {
		[
			try createData.leading.constraint(firstAnchor: leadingAnchor, secondAnchor: layoutGuide.leadingAnchor),
			try createData.top.constraint(firstAnchor: topAnchor, secondAnchor: layoutGuide.topAnchor),
			try createData.trailing.constraint(firstAnchor: trailingAnchor, secondAnchor: layoutGuide.trailingAnchor),
			try createData.bottom.constraint(firstAnchor: bottomAnchor, secondAnchor: layoutGuide.bottomAnchor)
		]
	}

	/// Make constraints from `self` to `view`.
	/// - Parameters:
	///   - view: View, whose anchors will be used for constraints.
	///   - insets: Insets for constraints.
	func makeConstraints(
		to view: UIView,
		insets: NSDirectionalEdgeInsets = .zero
	) -> [NSLayoutConstraint] {
		[
			leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.leading),
			topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
			trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.trailing),
			bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
		]
	}

	/// Make constraints from `self` to `view`.
	/// - Parameters:
	///   - view: View, whose anchors will be used for constraints.
	///   - createData: Data to create constraints.
	func makeConstraints(
		to view: UIView,
		createData: ConstraintsMakeData
	) throws -> [NSLayoutConstraint] {
		[
			try createData.leading.constraint(firstAnchor: leadingAnchor, secondAnchor: view.leadingAnchor),
			try createData.top.constraint(firstAnchor: topAnchor, secondAnchor: view.topAnchor),
			try createData.trailing.constraint(firstAnchor: trailingAnchor, secondAnchor: view.trailingAnchor),
			try createData.bottom.constraint(firstAnchor: bottomAnchor, secondAnchor: view.bottomAnchor)
		]
	}

	/// Adds default shadow to layer.
	/// - Parameters:
	///   - shadowColor: The color of the layer’s shadow.
	///   - animationDuration: Specifies the basic duration of the animation, in seconds.
	func addDefaultShadow(
		shadowColor: UIColor,
		animationDuration: TimeInterval = .defaultAnimationDuration
	) {
		let shadowPath = UIBezierPath(
			roundedRect: layer.bounds,
			cornerRadius: layer.cornerRadius
		)
		layer.apply(
			shadowParameters: .default(
				color: shadowColor.cgColor,
				path: shadowPath.cgPath,
				animationDuration: animationDuration
			)
		)
	}

	/// Resets shadow parameters
	func resetShadowParameters() {
		layer.shadowColor = nil
		layer.shadowOffset = .zero
		layer.shadowOpacity = .zero
		layer.shadowPath = nil
		layer.shadowRadius = .zero
	}

	/// Rounds corners to circle.
	func addDefaultCircleCorners() {
		layer.roundCornersToCircle(by: layer.bounds.size)
	}
}

public extension Array where Element == UIView {
	/// Add views in array as subview to specified `parentView` to use in constraints.
	/// - Parameter parentView: View, which will be parent for views in array.
	func addAsSubviewForConstraintsUse(to parentView: UIView) {
		for subview in self {
			parentView.addSubview(subview)
			subview.translatesAutoresizingMaskIntoConstraints = false
		}
	}
}

extension Array where Element == ShimmerableViewProtocol {
	func layoutIfNeeded() {
		compactMap { $0 as? UIView }.forEach { $0.layoutIfNeeded() }
	}
}

extension UIView {
	/// Returns existing shimmer layer in view.
	var shimmerLayers: [CALayer] {
		layer.sublayers?.filter { $0.name == CAGradientLayer.shimmerLayerName } ?? []
	}

	func actualContentHeight(width: CGFloat) -> CGFloat {
		let targetSize = CGSize(
			width: width,
			height: UIView.layoutFittingCompressedSize.height
		)
		let result = systemLayoutSizeFitting(
			targetSize,
			withHorizontalFittingPriority: .required,
			verticalFittingPriority: .fittingSizeLevel
		)
		return result.height
	}

	func actualContentWidth(availableHeight: CGFloat) -> CGFloat {
		let targetSize = CGSize(
			width: UIView.layoutFittingCompressedSize.width,
			height: availableHeight
		)
		let result = systemLayoutSizeFitting(
			targetSize,
			withHorizontalFittingPriority: .fittingSizeLevel,
			verticalFittingPriority: .required
		)
		return result.width
	}
}
