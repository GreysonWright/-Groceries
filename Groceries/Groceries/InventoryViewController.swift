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
		tabBarItem.image = #imageLiteral(resourceName: "ic_shopping_cart")
		
		cellNibName = "SelectableTableViewCell"
		reuseIdentifier = "SelectableCell"
		
		let row = TableViewRow(data: [])
		let row2 = TableViewRow(data: [])
		let row3 = TableViewRow(data: [])
		let row4 = TableViewRow(data: [])
		let row5 = TableViewRow(data: [])
		let row6 = TableViewRow(data: [])
		let section1 = TableViewSection(with: title, rows: [row, row2, row3, row4, row5, row6])
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
	
	override func setCellContent(_ tableview: UITableView, indexPath: IndexPath, cell: inout UITableViewCell) {
		let row = sections[indexPath.section].rows[indexPath.row]
		(cell as? SelectableTableViewCell)?.setContent(with: row)
	}
}

// MARK: - UITableView
extension InventoryViewController {
	// Delegate Methods
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
}
