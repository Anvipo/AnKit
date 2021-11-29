//
//  TableView.DiffableDataSource.swift
//  AnKit
//
//  Created by Anvipo on 29.11.2021.
//

import UIKit

extension TableView {
	@MainActor
	final class DiffableDataSource: UITableViewDiffableDataSource<
		TableViewSection,
		TableViewItem
	> {
		init(tableView: TableView) {
			super.init(tableView: tableView) { tableView, indexPath, item in
				Self.cellProvider(tableView: tableView, indexPath: indexPath, item: item)
			}
		}
	}
}

extension TableView.DiffableDataSource {
	var isDataEmpty: Bool {
		snapshot().numberOfSections == 0
	}
}

// MARK: - set(sections:animatingDifferences:completion:)
extension TableView.DiffableDataSource {
	func set(
		sections: [TableViewSection],
		animatingDifferences: Bool,
		completion: (() -> Void)? = nil
	) throws {
		var newSnapshot = Snapshot()

		try append(sections: sections, to: &newSnapshot)

		apply(
			newSnapshot,
			animatingDifferences: animatingDifferences,
			completion: completion
		)
	}

	@available(iOS 15, *)
	func set(
		sections: [TableViewSection],
		animatingDifferences: Bool
	) async throws {
		var newSnapshot = Snapshot()
		try append(sections: sections, to: &newSnapshot)

		await apply(newSnapshot, animatingDifferences: animatingDifferences)
	}
}

private extension TableView.DiffableDataSource {
	typealias Snapshot = NSDiffableDataSourceSnapshot<
		TableViewSection,
		TableViewItem
	>

	static func cellProvider(
		tableView: UITableView,
		indexPath: IndexPath,
		item: TableViewItem
	) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(
			withIdentifier: item.cellType.reuseIdentifier,
			for: indexPath
		)

		guard let castedCell = cell as? TableViewCell else {
			fatalError(
				"""
				Cell \(cell) should inherit TableViewCell.
				Table view: \(tableView)
				Index path: \(indexPath)
				Item: \(item)
				"""
			)
		}

		guard let tableView = tableView as? TableView else {
			fatalError(
				"""
				Table view \(tableView) should inherit TableView
				Cell: \(cell)
				Index path: \(indexPath)
				Item: \(item)
				"""
			)
		}

		guard let section = tableView.sections[safe: indexPath.section] else {
			fatalError(
				"""
				Table view must have specified section at index path \(indexPath)
				Table view: \(tableView)
				Index path: \(indexPath)
				"""
			)
		}

		let context = TableViewCell.FillMode.FromDataSourceContext(
			tableView: tableView,
			section: section
		)
		castedCell.fill(from: item, mode: .fromDataSource(context: context))

		return cell
	}

	func append(
		sections: [TableViewSection],
		to snapshot: inout Snapshot
	) throws {
		for section in sections {
			if let index = snapshot.indexOfSection(section) {
				fatalError("TODO")
//				throw CollectionView.DataSourceError.existingSection(
//					section,
//					sectionIndexInSnapshot: index
//				)
			}

			snapshot.appendSections([section])
		}

		try append(itemsToTheirSections: sections, to: &snapshot)
	}

	func append(
		itemsToTheirSections sections: [TableViewSection],
		to snapshot: inout Snapshot
	) throws {
		for section in sections {
			for item in section.items {
				if let index = snapshot.indexOfItem(item) {
					fatalError("TODO")
//					throw CollectionView.DataSourceError.existingItemInSection(
//						item,
//						section,
//						itemIndexInSnapshot: index
//					)
				}

				snapshot.appendItems(
					[item],
					toSection: section
				)
			}
		}
	}
}
