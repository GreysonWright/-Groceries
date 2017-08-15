//
//  AccountButtonTableViewCell.swift
//  Groceries
//
//  Created by Greyson Wright on 6/18/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class AccountButtonTableViewCell: UITableViewCell {
	@IBOutlet weak var button: UIButton!
	var buttonAction: ((Any) -> ())?
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
		button.backgroundColor = UIColor.secondary
		button.layer.cornerRadius = 2
    }
    
	@IBAction func buttonTapped(_ sender: Any) {
		buttonAction?(sender)
	}
}
