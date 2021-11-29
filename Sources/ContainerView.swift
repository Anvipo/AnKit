//
//  ContainerView.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import UIKit

/// View, which can contain other view with specified insets.
public final class ContainerView: UIView {
	/// Initializes view with specified parameters.
	/// - Parameters:
	///   - subview: Subview for container view.
	///   - subviewInsets: Insets for subview.
	public init(
		subview: UIView,
		subviewInsets: NSDirectionalEdgeInsets
	) {
		super.init(frame: .zero)

		addSubviewForConstraintsUse(subview)
		NSLayoutConstraint.activate(subview.makeConstraints(to: self, insets: subviewInsets))
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
