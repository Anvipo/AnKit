//
//  BasePlaygroundTableViewVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 29.11.2021.
//

import AnKit
import UIKit

class BasePlaygroundTableViewVC: BaseVC, PlaygroundVCProtocol {
	class var playgroundTitle: String {
		fatalError("Implement this method")
	}

	lazy var tableView = TableView()

	var initialSections: [TableViewSection] {
		get throws {
			fatalError("Implement this method")
		}
	}

	override init(output: BaseViewOutput?) {
		assert(!Self.playgroundTitle.isEmpty)
		super.init(output: output)
	}

	required convenience init() {
		self.init(output: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = Self.playgroundTitle
		setupUI()

		do {
			try fillTableView()
		} catch {
			assertionFailure(error.localizedDescription)
		}
	}

	func setupUI() {
		view.addSubviewForConstraintsUse(tableView)
		NSLayoutConstraint.activate(tableView.makeConstraints(to: view.safeAreaLayoutGuide))
	}
}

private extension BasePlaygroundTableViewVC {
	func fillTableView() throws {
		try tableView.set(
			sections: initialSections,
			animatingDifferences: shouldAnimate
		)
	}
}
