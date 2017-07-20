//
//  SelectItemViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/10/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class SelectItemViewController: BaseViewController {
	var realm: String?
	@IBOutlet weak var toolbar: UIToolbar!
	
	convenience init(with title: String?, realm: String?, listItems: [InventoryItem]) {
		self.init(with: title, realm: realm, sections: [])
		let section1 = buildSection(listItems: listItems)
		sections = [section1]
		self.realm = realm
	}
	
	fileprivate func buildSection(listItems: [InventoryItem]) -> TableViewSection {
		let section = TableViewSection(with: nil, rowData: listItems)
		section.collapsed = false
		section.collapsible = false
		return section
	}
	
	convenience init(with title: String?, realm: String?, sections: [TableViewSection]) {
		self.init(nibName: "SelectItemViewController", bundle: nil)
		self.title = title
		self.realm = realm
		self.sections = sections
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		cellNibName = "SelectableTableViewCell"
		reuseIdentifier = "SelectableCell"
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addItemsToToolbar()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		if !toolbar.isHidden {
			hideToolbar()
		}
	}
	
	fileprivate func addItemsToToolbar() {
		let favoriteBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_star"), style: .plain, target: self, action: #selector(favoriteBarButtonTapped))
		let flexibleSpaceItem1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
		let saveToBarButton = UIBarButtonItem(title: "Save To", style: .plain, target: self, action: #selector(saveToBarButtonTapped))
		let flexibleSpaceItem2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
		let deleteBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_clear"), style: .plain, target: self, action: #selector(deleteBarButtonTapped))
		toolbar.items = [favoriteBarButton, flexibleSpaceItem1, saveToBarButton, flexibleSpaceItem2, deleteBarButton]
		if (realm == nil) {
			deleteBarButton.isEnabled = false
		}
		if (realm == RealmManager.favoritesRealm) {
			favoriteBarButton.isEnabled = false
		}
	}
	
	func favoriteBarButtonTapped() {
		let selectedRows = getSelectedRows()
		let selectedRowData = extractFavoriteRowData(from: selectedRows)
		write(rowData: selectedRowData, to: RealmManager.favoritesRealm)
	}
	
	
	fileprivate func extractFavoriteRowData(from rows: [TableViewRow]) -> [InventoryItem] {
		let selectedRowData = rows.map { (row: TableViewRow) -> InventoryItem in
			let rowData = row.data as! InventoryItem
			let copiedItem = buildItemCopy(item: rowData)
			return copiedItem
		}
		return selectedRowData
	}
	
	func buildItemCopy(item: InventoryItem) -> InventoryItem {
		let copiedItem = InventoryItem()
		copiedItem.imageData = item.imageData
		copiedItem.title = item.title
		copiedItem.price = item.price
		copiedItem.title = item.title
		copiedItem.listTitle = RealmManager.favoritesRealm
		copiedItem.generatePrimaryKey()
		return copiedItem
	}
	
	fileprivate func write(rowData: [InventoryItem], to realmName: String) {
		do {
			let manager = try RealmManager(fileNamed: realmName)
			try manager.updatingAdd(rowData)
		} catch {
			print("Could not write to favorites")
		}
	}
	
	func saveToBarButtonTapped() {
		let selectedRows = getSelectedRows()
		let selectedRowData = extractRowData(from: selectedRows)
		let listsNavigationController = FatNavigationController(navigationBarClass: FatNavigationBar.self, toolbarClass: nil)
		let listViewController = ListsViewController(with: "Save To")
		listViewController.addToUserDefinedList(inventory: selectedRowData, target: self.navigationController!, navigationController: listsNavigationController) { (completed: Bool) in
			self.hideToolbar()
			self.navigationController?.popViewController(animated: true)
		}
	}
	
	func deleteBarButtonTapped() {
		guard let realm = realm else {
			return
		}
		let selectedRows = getSelectedRows()
		let selectedRowData = extractRowData(from: selectedRows)
		delete(items: selectedRowData, from: realm)
		realodTableView(in: realm)
		if realm != RealmManager.favoritesRealm {
			updateListPrice()
		}
	}
	
	fileprivate func getSelectedRows() -> [TableViewRow] {
		let selectedRows = sections.flatMap { (section: TableViewSection) -> [TableViewRow] in
			return section.selectedRows
		}
		return selectedRows
	}
	
	fileprivate func extractRowData(from rows: [TableViewRow]) -> [InventoryItem] {
		let selectedRowData = rows.map { (row: TableViewRow) in
			return row.data as! InventoryItem
		}
		return selectedRowData
	}
	
	fileprivate func delete(items: [InventoryItem], from realm: String) {
		guard let manager = try? RealmManager(fileNamed: realm) else {
			UIAlertController.showAlert(with: "Could not find realm.", on: self)
			return
		}
		do {
			try manager.delete(items)
		} catch {
			UIAlertController.showAlert(with: "Could not delete selected item(s).", on: self)
		}
	}
	
	fileprivate func realodTableView(in realm: String) {
		let listItems = getObjects(from: realm)
		let section = buildSection(listItems: listItems)
		sections = [section]
		tableView.reloadData()
	}
	
	fileprivate func updateListPrice() {
		guard let manager = try? RealmManager(fileNamed: RealmManager.listsRealm) else {
			UIAlertController.showAlert(with: "Could not find realm.", on: self)
			return
		}
		do {
			let list = try manager.getObject(ItemList.self, for: title!)
			try manager.update {
				list.calculateTotalPrice()
			}
		} catch {
			UIAlertController.showAlert(with: "Could not update \(title!) price.", on: self)
		}
	}
	
	fileprivate func getObjects(from realm: String) -> [InventoryItem] {
		guard let manager = try? RealmManager(fileNamed: realm) else {
			UIAlertController.showAlert(with: "Could not find realm.", on: self)
			return []
		}
		
		let results = manager.getAllObjects(InventoryItem.self)
		let objects = Array(results)
		return objects
	}
}

// MARK: - UITableView
extension SelectItemViewController {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = sections[indexPath.section].rows[indexPath.row]
		let rowData = row.data as! InventoryItem
		
		let cell = super.tableView(tableView, cellForRowAt: indexPath) as! SelectableTableViewCell
		cell.itemImageView?.image = rowData.image
		cell.titleTextLabel.text = rowData.title
		cell.priceTextLabel.text = String(format: "$%.2lf", rowData.price)
		if !row.selected {
			cell.selectedIconImageView.image = UIImage.unSelected
		} else {
			cell.selectedIconImageView.image = UIImage.selected
		}
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let row = sections[indexPath.section].rows[indexPath.row]
		row.selected = !row.selected
		tableView.reloadData()
		hideToolBarIfNeed()
	}
	
	fileprivate func hideToolBarIfNeed() {
		if shouldShowToolbar() {
			showToolbar()
		} else {
			hideToolbar()
		}
	}
	
	fileprivate func shouldShowToolbar() -> Bool {
		let selectedRowCount = getSelectedRowCount()
		return selectedRowCount > 0
	}
	
	fileprivate func showToolbar() {
		tabBarController?.tabBar.isHidden = true
		toolbar.isHidden = false
	}
	
	fileprivate func hideToolbar() {
		tabBarController?.tabBar.isHidden = false
		toolbar.isHidden = true
	}
	
	fileprivate func getSelectedRowCount() -> Int {
		var selectedRowCount = 0
		sections.forEach { (section: TableViewSection) in
			selectedRowCount += section.selectedRowCount
		}
		return selectedRowCount
	}
}
