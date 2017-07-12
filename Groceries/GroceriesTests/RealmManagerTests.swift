//
//  RealmWriterTests.swift
//  Groceries
//
//  Created by Greyson Wright on 7/10/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Groceries

class RealmManagerTests: XCTestCase {
	var manager: RealmManager!
	
    override func setUp() {
        super.setUp()
		
		initRealmManager()
    }
	
	func initRealmManager() {
		manager = RealmManager()
		try! manager.createRealm(named: "Test")
	}
	
	override func tearDown() {
		super.tearDown()
		
		try! manager.deleteAll()
	}
	
	func testAddSingle() {
		let item = buildItem(with: "Item 0", price: 0.0)
		try! manager.add(object: item)
		let dbItems = manager.getAllObjects(InventoryItem.self)
		XCTAssertEqual(dbItems.count, 1)
	}
	
	func testAddMultiple() {
		let items: [InventoryItem] = buildItems()
		try! manager.add(objects: items)
		let dbItems = manager.getAllObjects(InventoryItem.self)
		XCTAssertEqual(dbItems.count, items.count)
	}
	
	func testRemoveAll() {
		let items = buildItems()
		try! manager.add(objects: items)
		try! manager.deleteAll()
		let dbObjects = manager.getAllObjects(InventoryItem.self)
		XCTAssertEqual(dbObjects.count, 0)
	}
	
	func testRemoveSingle() {
		let item = buildItem(with: "Item 0", price: 0.0)
		try! manager.add(object: item)
		try! manager.delete(object: item)
		let dbObjects = manager.getAllObjects(InventoryItem.self)
		XCTAssertEqual(dbObjects.count, 0)
	}
	
	func testReadAll() {
		let items: [InventoryItem] = buildItems()
		try! manager.add(objects: items)
		let inventoryItems = manager.getAllObjects(InventoryItem.self)
		for i in 0 ..< items.count {
			let readItem = inventoryItems[i]
			let item = items[i]
			XCTAssertEqual(areInventoryItemsEqual(readItem, item), true)
		}
	}
	
	func buildItems() -> [InventoryItem] {
		var items: [InventoryItem] = []
		for i in 1...9 {
			let item = buildItem(with: "Item \(i)", price: Double(i + i))
			items.append(item)
		}
		return items
	}
	
	func buildItem(with name: String, price: Double) -> InventoryItem {
		let item = InventoryItem()
		item.title = name
		item.price = price
		return item
	}
	
	func areInventoryItemsEqual(_ left: InventoryItem, _ right: InventoryItem) -> Bool {
		return left.title == right.title && left.price == right.price
	}
	
	func testRemoveRealm() {
		try! manager.removeRealm(named: "Test")
		XCTAssertEqual(Realm.exists(named: "Test"), false)
	}
}
