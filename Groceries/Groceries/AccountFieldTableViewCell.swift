//
//  AccountFieldTableViewCell.swift
//  Groceries
//
//  Created by Greyson Wright on 6/18/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AccountFieldTableViewCell: UITableViewCell {
	@IBOutlet weak var textField: SkyFloatingLabelTextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
}
