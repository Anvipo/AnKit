//
//  ChangeItemHeightVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 07.11.2021.
//

import AnKit
import UIKit

final class ChangeItemHeightVC: BasePlaygroundVC {
	override class var playgroundTitle: String {
		"Change item height example"
	}

	private let numberFormatter: NumberFormatterProtocol
	private let animationDurationPickerItemID: CollectionViewItem.ID
	private let textLabelTransitionTypePickerID: CollectionViewItem.ID
	private weak var expandByReconfigureItem: ExpandableTextItem?

	override init(output: BaseViewOutput?) {
		numberFormatter = DependenciesStorage.shared.numberFormatter
		animationDurationPickerItemID = CollectionViewItem.ID()
		textLabelTransitionTypePickerID = CollectionViewItem.ID()

		super.init(output: output)
	}

	override func initialSections() throws -> [CollectionViewSection] {
		var sections = [CollectionViewSection]()

		let expandByReloadItemSection = try expandByReloadItemSection
		sections.append(expandByReloadItemSection)

		if #available(iOS 15, *) {
			sections.append(try expandByReconfigureSection)

			expandByReloadItemSection.contentInsets.bottom = 32
		}

		return sections
	}

	override func setupUI() {
		super.setupUI()
		view.backgroundColor = .systemGroupedBackground
		collectionView.keyboardDismissMode = .onDrag
		setupGestureRecognizer()
	}
}

extension ChangeItemHeightVC: StringFieldItemDelegate {
	func stringFieldItemDidChangeString(_ item: StringFieldItem) {
		guard let expandByReconfigureItem = expandByReconfigureItem,
			  item.id == animationDurationPickerItemID
		else {
			assertionFailure("?")
			return
		}

		expandByReconfigureItem.animationDuration = numberFormatter.double(from: item.text)
	}
}

extension ChangeItemHeightVC: PickerFieldItemDelegate {
	func pickerFieldItemDidChangeComponent(
		_ item: PickerFieldItem,
		component: PickerFieldItem.SelectedComponentInfo
	) {
		guard let expandByReconfigureItem = expandByReconfigureItem,
			  item.id == textLabelTransitionTypePickerID
		else {
			assertionFailure("?")
			return
		}

		expandByReconfigureItem.textLabelTransitionType = CATransitionType.allCases[component.componentRowIndex]
	}
}

private extension ChangeItemHeightVC {
	var expandByReloadItemSection: CollectionViewSection {
		// swiftlint:disable:next implicit_getter
		get throws {
			let expandByReloadItem = try ExpandableTextItem(text: .mock)
			expandByReloadItem.onTapExpandButton = { [weak self, weak expandByReloadItem] in
				guard let self = self,
					  let expandByReloadItem = expandByReloadItem
				else {
					return
				}

				do {
					try self.didTap(expandByReloadItem: expandByReloadItem)
				} catch {
					assertionFailure(error.localizedDescription)
				}
			}

			return try PlainListSection(
				items: [expandByReloadItem],
				headerItem: try AnKitPlayground.makePlainLabelBoundarySupplementaryItem(
					text: "Expand by reload method",
					elementKind: "PlainLabelBoundarySupplementaryItem",
					blurEffectStyle: nil,
					pinToVisibleBounds: false
				),
				contentInsets: .default
			)
		}
	}

	@available(iOS 15, *)
	var expandByReconfigureSection: CollectionViewSection {
		// swiftlint:disable:next implicit_getter
		get throws {
			let expandByReconfigureItem = try ExpandableTextItem(text: .mock) { [weak self] in
				do {
					try self?.didTapExpandByReconfigureItem()
				} catch {
					assertionFailure(error.localizedDescription)
				}
			}
			self.expandByReconfigureItem = expandByReconfigureItem

			let animationDuration: TimeInterval = 0.3
			let selectedComponent = PickerFieldItem.SelectedComponentInfo.zero
			let textLabelTransitionType = CATransitionType.allCases[selectedComponent.componentRowIndex]
			expandByReconfigureItem.animationDuration = animationDuration
			expandByReconfigureItem.textLabelTransitionType = textLabelTransitionType

			let animationDurationFieldItem = try AnKitPlayground.makeStringFieldItem(
				id: animationDurationPickerItemID,
				title: "Animation duration (sec)",
				text: "\(animationDuration)",
				textKeyboardType: .decimalPad,
				delegate: self
			)

			let textLabelTransitionTypePickerFieldItem = try AnKitPlayground.makeTransitionTypePickerFieldItem(
				id: textLabelTransitionTypePickerID,
				title: "Cell transition type",
				selectedComponent: selectedComponent,
				delegate: self
			)

			return try PlainListSection(
				items: [
					animationDurationFieldItem,
					PlainSpacerItem(height: 32),
					textLabelTransitionTypePickerFieldItem,
					PlainSpacerItem(height: 32),
					expandByReconfigureItem
				],
				headerItem: try AnKitPlayground.makePlainLabelBoundarySupplementaryItem(
					text: "Expand by reconfigure method",
					elementKind: "PlainLabelBoundarySupplementaryItem",
					blurEffectStyle: nil,
					pinToVisibleBounds: false
				),
				contentInsets: .default
			)
		}
	}

	func didTap(expandByReloadItem: ExpandableTextItem) throws {
		expandByReloadItem.isExpanded.toggle()

		try collectionView.reload(
			items: [expandByReloadItem],
			animatingDifferences: shouldAnimateDifferences
		)
	}

	@available(iOS 15, *)
	func didTapExpandByReconfigureItem() throws {
		guard let expandByReconfigureItem = expandByReconfigureItem else {
			assertionFailure("?")
			return
		}

		expandByReconfigureItem.isExpanded.toggle()

		if let animationDuration = expandByReconfigureItem.animationDuration {
			UIView.animate(withDuration: animationDuration) { [self] in
				try? collectionView.reconfigureOrReload(
					items: [expandByReconfigureItem],
					animatingDifferences: shouldAnimateDifferences
				)
			}
		} else {
			try collectionView.reconfigureOrReload(
				items: [expandByReconfigureItem],
				animatingDifferences: shouldAnimateDifferences
			)
		}
	}

	@objc
	func didTapView() {
		view.endEditing(true)
	}

	func setupGestureRecognizer() {
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
		tapGestureRecognizer.cancelsTouchesInView = false
		view.addGestureRecognizer(tapGestureRecognizer)
	}
}
