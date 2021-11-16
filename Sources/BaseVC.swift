//
//  BaseVC.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import Combine
import UIKit

/// View controller with additional methods, which could be placed in UIKit.
open class BaseVC: UIViewController {
	private let output: BaseViewOutput?
	private var subscriptions: [AnyCancellable]

	/// The status bar style for the view controller.
	public final var statusBarStyle: UIStatusBarStyle {
		didSet {
			setNeedsStatusBarAppearanceUpdate()
		}
	}

	/// Views, which could be shimmered.
	public final var shimmerableViews: [ShimmerableViewProtocol]

	/// The preferred status bar style for the view controller.
	override public final var preferredStatusBarStyle: UIStatusBarStyle {
		statusBarStyle
	}

	/// Is view visible to user.
	public private(set) final var isViewVisible: Bool

	/// Initializes view controller with specified `output`.
	/// - Parameter output: Output subject for this view controller.
	public init(output: BaseViewOutput?) {
		self.output = output
		shimmerableViews = []
		statusBarStyle = .default
		isViewVisible = false
		subscriptions = []

		super.init(nibName: nil, bundle: nil)
	}

	/// Initializes view controller with nil `output`.
	public convenience init() {
		self.init(output: nil)
	}

	@available(*, unavailable)
	override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		fatalError("init(nibName:bundle:) has not been implemented")
	}

	@available(*, unavailable)
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override open func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
	}

	override open func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		isViewVisible = true
		output?.baseViewDidAppear()
	}

	override open func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		isViewVisible = false
	}

	override open func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		shimmerableViews.layoutShimmers()
	}

	deinit {
		for subscription in subscriptions {
			subscription.cancel()
		}

		subscriptions = []
	}
}

public extension BaseVC {
	/// Should animate the updates in the views.
	var shouldAnimate: Bool {
		if !UIView.areAnimationsEnabled {
			return false
		}

		return isViewVisible
	}

	/// Add view controller as observer fo keyboard will show event.
	/// - Parameter onReceiveNotification: Closure for handling notification.
	func observeKeyboardWillShow(
		onReceiveNotification: @escaping (Result<KeyboardNotification, KeyboardNotification.MapFromNotificationError>) -> Void
	) {
		let keyboardWillShowSubscription = KeyboardSubscriptions.willShowSubscription(
			onReceiveNotification: onReceiveNotification
		)
		subscriptions.append(keyboardWillShowSubscription)
	}

	/// Add view controller as observer fo keyboard did show event.
	/// - Parameter onReceiveNotification: Closure for handling notification.
	func observeKeyboardDidShow(
		onReceiveNotification: @escaping (Result<KeyboardNotification, KeyboardNotification.MapFromNotificationError>) -> Void
	) {
		let keyboardDidShowSubscription = KeyboardSubscriptions.didShowSubscription(
			onReceiveNotification: onReceiveNotification
		)
		subscriptions.append(keyboardDidShowSubscription)
	}

	/// Add view controller as observer fo keyboard will hide event.
	/// - Parameter onReceiveNotification: Closure for handling notification.
	func observeKeyboardWillHide(
		onReceiveNotification: @escaping (Result<KeyboardNotification, KeyboardNotification.MapFromNotificationError>) -> Void
	) {
		let keyboardWillHideSubscription = KeyboardSubscriptions.willHideSubscription(
			onReceiveNotification: onReceiveNotification
		)
		subscriptions.append(keyboardWillHideSubscription)
	}

	/// Add view controller as observer fo keyboard did hide event.
	/// - Parameter onReceiveNotification: Closure for handling notification.
	func observeKeyboardDidHide(
		onReceiveNotification: @escaping (Result<KeyboardNotification, KeyboardNotification.MapFromNotificationError>) -> Void
	) {
		let keyboardDidHideSubscription = KeyboardSubscriptions.didHideSubscription(
			onReceiveNotification: onReceiveNotification
		)
		subscriptions.append(keyboardDidHideSubscription)
	}
}
