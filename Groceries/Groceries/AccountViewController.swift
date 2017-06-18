//
//  AccountViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/3/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class AccountViewController: BaseViewController {	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		cellNibName = "AccountTableViewCell"
		reuseIdentifier = "AccountCell"
		
		title = "Account"
		tabBarItem.image = UIImage.account
		
		let nameField = AccountField()
		nameField.placeHolder = "Name"
		
		let emailField = AccountField()
		emailField.placeHolder = "Email"
		
		let passwordField = AccountField()
		passwordField.placeHolder = "Password"
		
		let accountFields = [nameField, emailField, passwordField]
		
		let section = TableViewSection(with: nil, rowData: accountFields)
		section.collapsed = false
		sections.append(section)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

// MARK: - UITableView
extension AccountViewController {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = sections[indexPath.section].rows[indexPath.row]
		let rowData = row.data as! AccountField
		
		let cell = super.tableView(tableView, cellForRowAt: indexPath) as! AccountTableViewCell
		cell.textField.placeholder = rowData.placeHolder
		cell.textField.text = rowData.text
		return cell
	}
}

