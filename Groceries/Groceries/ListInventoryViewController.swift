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
		section1.collapsable = false
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
