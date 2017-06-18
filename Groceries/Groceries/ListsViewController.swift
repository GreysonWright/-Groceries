//
//  ListsViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/12/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class ListsViewController: BaseViewController {
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		cellNibName = "ListTableViewCell"
		reuseIdentifier = "ListCell"
		
		var lists: [List] = []
		for i in 0...12 {
			let list = List()
			list.title = "list\(i)"
			list.totalPrice = "$\(i * i).\(i)"
			lists.append(list)
		}
		let section1 = TableViewSection(with: nil, rowData: lists)
		section1.collapsed = false
		sections.append(section1)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
extension ListsViewController {
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 48
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = sections[indexPath.section].rows[indexPath.row]
		let rowData = row.data as! List
		
		let cell = super.tableView(tableView, cellForRowAt: indexPath) as! ListTableViewCell
		cell.titleLabel.text = rowData.title
		cell.priceLabel.text = rowData.totalPrice
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		let row = sections[indexPath.section].rows[indexPath.row]
//		let rowData = row.data as! List
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
