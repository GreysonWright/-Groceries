//
//  SelectItemViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/10/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class SelectItemViewController: BaseViewController {
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)		
		cellNibName = "SelectableTableViewCell"
		reuseIdentifier = "SelectableCell"
		
		var inventoryData: [InventoryItem] = []
		for i in 0...8 {
			let inventoryItem = InventoryItem()
			inventoryItem.title = "test\(i)"
			inventoryItem.price = "$\(i + i).00"
			inventoryData.append(inventoryItem)
		}
		let section1 = TableViewSection(with: "test section", rowData: inventoryData)
		sections.append(section1)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.register(nib: cellNibName, forCellReuseIdentifier: reuseIdentifier)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

// MARK: - UITableView
extension SelectItemViewController {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 48
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = sections[indexPath.section].rows[indexPath.row]
		let rowData = row.data as! InventoryItem
		
		let cell = super.tableView(tableView, cellForRowAt: indexPath) as! SelectableTableViewCell
		cell.titleTextLabel.text = rowData.title
		cell.priceTextLabel.text = rowData.price
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
	}
}
