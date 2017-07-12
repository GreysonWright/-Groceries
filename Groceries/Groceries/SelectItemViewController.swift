//
//  SelectItemViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/10/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class SelectItemViewController: BaseViewController {
	@IBOutlet weak var toolbar: UIToolbar!
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)		
		cellNibName = "SelectableTableViewCell"
		reuseIdentifier = "SelectableCell"
		
		var inventoryData: [InventoryItem] = []
		for i in 0...15 {
			let inventoryItem = InventoryItem()
			inventoryItem.title = "test\(i)"
			inventoryItem.price = Double(i + i)
			inventoryData.append(inventoryItem)
		}
		
		let section1 = TableViewSection(with: "test section1", rowData: inventoryData)
		let section2 = TableViewSection(with: "test section2", rowData: inventoryData)
		
		sections = [section1, section2]
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addItemsToToolbar()
	}
	
	func addItemsToToolbar() {
		let favoriteBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_star_border"), style: .plain, target: self, action: #selector(favoriteBarButtonTapped))
		let flexibleSpaceItem1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
		let saveToBarButton = UIBarButtonItem(title: "Save To", style: .plain, target: self, action: #selector(saveToBarButtonTapped))
		let flexibleSpaceItem2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
		let deleteBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_clear"), style: .plain, target: self, action: #selector(deleteBarButtonTapped))
		toolbar.items = [favoriteBarButton, flexibleSpaceItem1, saveToBarButton, flexibleSpaceItem2, deleteBarButton]
	}
	
	func favoriteBarButtonTapped() {
		let selectedRows = getSelectedRows()
		let selectedRowData = extractRowData(from: selectedRows)
		write(rowData: selectedRowData, to: "Favorites")
		hideToolbar()
		navigationController?.popViewController(animated: true)
	}
	
	func saveToBarButtonTapped() {
		
	}
	
	func deleteBarButtonTapped() {
		
	}
	
	func getSelectedRows() -> [TableViewRow] {
		let selectedRows = sections.flatMap { (section: TableViewSection) -> [TableViewRow] in
			return section.selectedRows
		}
		return selectedRows
	}
	
	func extractRowData(from rows: [TableViewRow]) -> [InventoryItem] {
		let selectedRowData = rows.map { (row: TableViewRow) in
			return row.data
		}
		return selectedRowData as! [InventoryItem]
	}
	
	func write(rowData: [InventoryItem], to realmName: String) {
		do {
			let manager = try RealmManager(fileNamed: realmName)
			try manager.add(objects: rowData)
		} catch {
			print("Could not write to favorites")
		}
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
		//		cell?.setSelected(row.selected, animated: false)
		tableView.reloadData()
		
		toggleToolBarHidden()
	}
	
	func toggleToolBarHidden() {
		if shouldShowToolbar() {
			showToolbar()
		} else {
			hideToolbar()
		}
	}
	
	func shouldShowToolbar() -> Bool {
		let selectedRowCount = getSelectedRowCount()
		return selectedRowCount > 0
	}
	
	func showToolbar() {
		tabBarController?.tabBar.isHidden = true
		toolbar.isHidden = false
	}
	
	func hideToolbar() {
		tabBarController?.tabBar.isHidden = false
		toolbar.isHidden = true
	}
	
	func getSelectedRowCount() -> Int {
		var selectedRowCount = 0
		sections.forEach { (section: TableViewSection) in
			selectedRowCount += section.rowCount
		}
		return selectedRowCount
	}
}
