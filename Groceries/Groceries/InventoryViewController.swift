//
//  InventoryViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/3/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class InventoryViewController: BaseViewController {
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		title = "Inventory"
		tabBarItem.image = UIImage.inventory
		
		var storeCategories: [StoreCategory] = []
		for i in 0...8 {
			let category = StoreCategory()
			category.image = #imageLiteral(resourceName: "ic_shopping_cart")
			category.title = "category\(i)"
			storeCategories.append(category)
		}
		
		let section1 = TableViewSection(with: "Walmart", rowData: storeCategories)
		section1.collapsed = false
		section1.collapsible = false
		sections.append(section1)

	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

// MARK: - UITableView
extension InventoryViewController {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 48
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = sections[indexPath.section].rows[indexPath.row]
		let rowData = row.data as! StoreCategory
		
		let cell = super.tableView(tableView, cellForRowAt: indexPath)
		cell.imageView?.image = rowData.image
		cell.textLabel?.text = rowData.title
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let row = sections[indexPath.section].rows[indexPath.row]
		let rowData = row.data as! StoreCategory
		
		let selectItemViewController = SelectItemViewController(nibName: "SelectItemViewController", bundle: nil)
		selectItemViewController.title = rowData.title
		navigationController?.pushViewController(selectItemViewController, animated: true)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
