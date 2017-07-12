//
//  List.swift
//  Groceries
//
//  Created by Greyson Wright on 6/12/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit
import RealmSwift

class ItemList: Object {
	dynamic var title = ""
	dynamic var totalPrice: Double = 0.0
	var items = List<InventoryItem>()
}
