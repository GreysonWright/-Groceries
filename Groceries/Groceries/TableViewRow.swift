//
//  TableViewRow.swift
//  Groceries
//
//  Created by Greyson Wright on 6/9/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class TableViewRow {
	var image: UIImage?
	var title: String?
	var selected: Bool
	
	init(image: UIImage?, title: String?) {
		self.image = image
		self.title = title
		selected = false
	}
	
	convenience init (title: String?) {
		self.init(image: nil, title: title)
	}
}
