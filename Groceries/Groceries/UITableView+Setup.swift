//
//  TableView+Setup.swift
//  Groceries
//
//  Created by Greyson Wright on 6/3/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

extension UITableView {
	func register(nib nibName: String, forCellReuseIdentifier reuseIdentifier: String) {
		let nib = UINib(nibName: nibName, bundle: nil)
		register(nib, forCellReuseIdentifier: reuseIdentifier)
	}
}
