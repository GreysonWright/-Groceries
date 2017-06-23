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
		
		textField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard let textFieldReturnAction = textFieldReturnAction else {
			return true
		}
		return textFieldReturnAction(textField)
	}
}
