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
	fileprivate(set) public var rows: [TableViewRow]
	var collapsed: Bool
	var collapsible: Bool
	var rowCount: Int {
		return rows.count
	}
	
	init(with title: String?, rows: [TableViewRow]) {
		self.title = title
		self.rows = rows
		collapsed = true
		collapsible = true
	}
	
	convenience init(with title: String?, rowData: [Any]) {
		self.init(with: title, rows: [])
		addRows(with: rowData)
	}
	
	convenience init(with title: String?) {
		self.init(with: title, rows: [])
	}
	
	func addRow(with data: Any) {
		let newRow = TableViewRow(data: data)
		rows.append(newRow)
	}
	
	func addRows(with data: [Any]) {
		data.forEach { (dataItem: Any) in
			addRow(with: dataItem)
		}
	}
}
