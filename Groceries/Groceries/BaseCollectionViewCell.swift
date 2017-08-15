//
//  BaseCollectionViewCell.swift
//  Groceries
//
//  Created by Greyson Wright on 6/3/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var itemImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
	
	func setContent(data: BaseCollectionViewCellData) {
		if (data.image != nil) {
			itemImageView.backgroundColor = UIColor.clear
		}
		itemImageView.tintColor = data.imageColor
		itemImageView.image = data.image
		titleLabel.text = data.title
	}
}
