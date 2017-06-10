//
//  TableViewRow.swift
//  Groceries
//
//  Created by Greyson Wright on 6/9/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class TableViewRow {
	var selected: Bool
	var data: Any
	
	init (data: Any) {
		self.data = data
		selected = false
	}
}
