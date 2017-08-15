//
//  AccountFieldTableViewCell.swift
//  Groceries
//
//  Created by Greyson Wright on 6/18/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AccountFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
	@IBOutlet weak var textField: SkyFloatingLabelTextField!
	var textFieldReturnAction: ((UITextField) -> Bool)?
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
		setupTextField()
    }
	
	func setupTextField() {
		textField.delegate = self
		textField.tintColor = UIColor.secondary
		textField.selectedTitleColor = UIColor.secondary
		textField.selectedLineColor = UIColor.secondary
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard let textFieldReturnAction = textFieldReturnAction else {
			return true
		}
		return textFieldReturnAction(textField)
	}
}
