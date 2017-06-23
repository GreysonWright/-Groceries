//
//  AccountViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/3/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class AccountViewController: BaseViewController {
	var textFields: [Int : UITextField] = [:]
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		cellNibName = "AccountFieldTableViewCell"
		reuseIdentifier = "AccountFieldCell"
		
		title = "Account"
		tabBarItem.image = UIImage.account
		
		let nameField = AccountField()
		nameField.placeHolder = "Name"
		
		let emailField = AccountField()
		emailField.placeHolder = "Email"
		
		let passwordField = AccountField()
		passwordField.placeHolder = "Password"
		
		let accountFields = [nameField, emailField, passwordField]
		
		let fieldSection = TableViewSection(with: nil, rowData: accountFields)
		fieldSection.collapsed = false
		
		let saveButton = AccountField()
		saveButton.text = "Save"
		
		let buttonSection = TableViewSection(with: nil, rowData: [saveButton])
		buttonSection.collapsed = false
		
		sections = [fieldSection, buttonSection]
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.register(nib: "AccountButtonTableViewCell", forCellReuseIdentifier: "AccountButtonCell")
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
		
		if indexPath.section == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! AccountFieldTableViewCell
			cell.textField.placeholder = rowData.placeHolder
			cell.textField.text = rowData.text
			cell.textField.tag = indexPath.row
			cell.textFieldReturnAction = textFieldShouldReturn
			textFields[indexPath.row] = cell.textField
			return cell
		}
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "AccountButtonCell") as! AccountButtonTableViewCell
		cell.buttonAction = saveButtonTapped
		cell.button.setTitle("Save", for: .normal)
		return cell
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField.tag == 2 {
			saveButtonTapped(textField)
		} else {
			textFields[textField.tag + 1]?.becomeFirstResponder()
		}
		return true
	}
	
	func saveButtonTapped(_ sender: Any) {
		// save stuff
		print("saved")
		textFields.keys.forEach { (key: Int) in
			textFields[key]?.endEditing(true)
		}
	}
}
