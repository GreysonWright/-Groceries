//
//  Row.swift
//  Groceries
//
//  Created by Greyson Wright on 3/4/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import Foundation
import UIKit

class Row {
	var image: UIImage?
	var title: String?
	var description: String?
	var accessoryType: UITableViewCellAccessoryType
	
	init(image: UIImage?, title: String?, description: String?, accessoryType: UITableViewCellAccessoryType) {
		self.image = image
		self.title = title
		self.description = description
		self.accessoryType = accessoryType
	}
}
