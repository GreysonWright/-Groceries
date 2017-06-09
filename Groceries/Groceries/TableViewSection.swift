//
//  TableViewSection.swift
//  Groceries
//
//  Created by Greyson Wright on 6/9/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class TableViewSection {
	var title: String?
	var rows: [TableViewRow]
	var collapsed: Bool
	var rowCount: Int {
		return rows.count
	}
	
	init(with title: String?, rows: [TableViewRow]) {
		self.title = title
		self.rows = rows
		collapsed = true
	}
	
	convenience init(title: String?) {
		self.init(with: title, rows: [])
	}
}
