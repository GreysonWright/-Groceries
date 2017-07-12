//
//  ListItemsViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 7/12/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class ListInventoryViewController: BaseViewController {
	convenience init(with title: String, inventory: [InventoryItem]) {
		self.init(nibName: "ListInventoryViewController", bundle: nil)
		self.title = title
		
		let section1 = TableViewSection(with: nil, rowData: inventory)
		section1.collapsed = false
		section1.collapsible = false
		sections.append(section1)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableView
extension ListInventoryViewController {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 48
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = sections[indexPath.section].rows[indexPath.row]
		let rowData = row.data as! ItemList
		
		let cell = super.tableView(tableView, cellForRowAt: indexPath) as! ListTableViewCell
		cell.titleLabel.text = rowData.title
		cell.priceLabel.text = String(format: "$%.2lf", rowData.totalPrice)
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//		let row = sections[indexPath.section].rows[indexPath.row]
		//		let rowData = row.data as! List
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
