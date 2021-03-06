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
		
		addSectionsToTableView()
	}
	
	func addSectionsToTableView() {
		let fieldPlaceHolders = ["NAME", "EMAIL", "PASSWORD"]
		let accountFields = buildAccountFields(with: fieldPlaceHolders)
		let fieldSection = buildFixedTableViewSection(with: accountFields)
		
		let saveButton = AccountField()
		saveButton.text = "Save"
		let buttonSection = buildFixedTableViewSection(with: [saveButton])
		
		sections = [fieldSection, buttonSection]
	}
	
	func buildAccountFields(with placeHolders: [String]) -> [AccountField] {
		var accountFields: [AccountField] = []
		placeHolders.forEach { (placeHolder: String) in
			let field = buildAccountField(with: placeHolder)
			accountFields.append(field)
		}
		return accountFields
	}
	
	func buildAccountField(with placeHolder: String) -> AccountField {
		let accountField = AccountField()
		accountField.placeHolder = placeHolder
		return accountField
	}
	
	func buildFixedTableViewSection(with data: [Any]) -> TableViewSection {
		let section = TableViewSection(with: nil, rowData: data)
		section.collapsed = false
		return section
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
		if indexPath.section < sections.count - 1 {
			return 50
		}
		
		return 70
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
