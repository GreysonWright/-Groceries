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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	@IBAction func buttonTapped(_ sender: Any) {
		buttonAction?(sender)
	}
}
