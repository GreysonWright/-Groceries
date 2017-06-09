//
//  InventoryViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/3/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class InventoryViewController: BaseViewController {
	let cellNibName = "BaseTableViewCell"
	let reuseIdentifier = "BaseCell"
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		title = "Inventory"
		tabBarItem.image = #imageLiteral(resourceName: "ic_shopping_cart")
		
		let row = TableViewRow(title: "idk")
		let section1 = TableViewSection(title: "test")
		section1.rows.append(row)
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
//
//// MARK: - UITableView
//extension InventoryViewController {
//	
//}
