//
//  InventoryItem.swift
//  Groceries
//
//  Created by Greyson Wright on 6/10/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit
import RealmSwift

class InventoryItem: Object {
	dynamic var title: String = ""
	dynamic var price: Double = 0.0
}
