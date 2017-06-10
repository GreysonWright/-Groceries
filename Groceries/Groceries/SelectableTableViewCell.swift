//
//  SelectableTableViewCell.swift
//  Groceries
//
//  Created by Greyson Wright on 6/9/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class SelectableTableViewCell: UITableViewCell {
	@IBOutlet weak var selectedIconImageView: UIImageView!
	@IBOutlet weak var titleTextLabel: UILabel!
	@IBOutlet weak var priceTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func setCellContent(with row: TableViewRow) {
		
	}
}
