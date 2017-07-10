//
//  RealmWriterTests.swift
//  Groceries
//
//  Created by Greyson Wright on 7/10/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import XCTest
@testable import Groceries

class RealmWriterTests: XCTestCase {
	var writer: RealmWriter!
	
    override func setUp() {
        super.setUp()
		
		writer = try! RealmWriter()
		try! writer.createRealm(named: "Test")
    }
	
	func testWrite() {
		let testItem = InventoryItem()
		testItem.title = "Test Item"
		testItem.price = 100.00
		try! writer.write(object: testItem)
	}
}
