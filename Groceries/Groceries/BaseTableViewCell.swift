//
//  BaseTableViewCell.swift
//  Groceries
//
//  Created by Greyson Wright on 3/4/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func configureCell(row: Row) {
		
	}
}
