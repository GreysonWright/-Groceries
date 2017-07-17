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
		manager = try! RealmManager(fileNamed: RealmManager.testRealm)
	}
	
	override func tearDown() {
		super.tearDown()
		
		try! manager.deleteAll()
	}
	
	func testAddSingle() {
		let item = buildItem(with: "Item 0", price: 0.0)
		try! manager.add(item)
		let dbItems = manager.getAllObjects(InventoryItem.self)
		XCTAssertEqual(dbItems.count, 1)
	}
	
	func testUpdatingAddSingle() {
		let item = buildItem(with: "Item 0", price: 0.0)
		try! manager.add(item)
		let updatedItem = buildItem(with: "Item 0", price: 10.0)
		try! manager.updatingAdd(updatedItem)
		let dbItems = manager.getAllObjects(InventoryItem.self)
		let dbItem = dbItems.first!
		XCTAssertEqual(dbItem.price, 10.0)

	}
	
	func testAddMultiple() {
		let items = buildItems()
		try! manager.add(items)
		let dbItems = manager.getAllObjects(InventoryItem.self)
		XCTAssertEqual(dbItems.count, items.count)
	}
	
	func testUpdatingAddMultiple() {
		let items = buildItems()
		try! manager.add(items)
		let updatedItems = buildUpdatedItems(with: items)
		try! manager.updatingAdd(updatedItems)
		let dbItems = manager.getAllObjects(InventoryItem.self)
		
		for i in 0 ..< items.count {
			let item = updatedItems[i]
			let updatedItem = dbItems[i]
			XCTAssert(areInventoryItemsEqual(item, updatedItem))
		}
	}
	
	func buildUpdatedItems(with items: [InventoryItem]) -> [InventoryItem] {
		var updatedItems: [InventoryItem] = []
		items.forEach { (item: InventoryItem) in
			let newItem = buildItem(with: item.title, price: item.price + 10)
			updatedItems.append(newItem)
		}
		return updatedItems
	}
	
	func testRemoveAll() {
		let items = buildItems()
		try! manager.add(items)
		try! manager.deleteAll()
		let dbObjects = manager.getAllObjects(InventoryItem.self)
		XCTAssertEqual(dbObjects.count, 0)
	}
	
	func testRemoveSingle() {
		let item = buildItem(with: "Item 0", price: 0.0)
		try! manager.add(item)
		try! manager.delete(item)
		let dbObjects = manager.getAllObjects(InventoryItem.self)
		XCTAssertEqual(dbObjects.count, 0)
	}
	
	func testRemoveMultiple() {
		let items = buildItems()
		try! manager.add(items)
		var dbObjects = manager.getAllObjects(InventoryItem.self)
		try! manager.delete(Array(dbObjects))
		dbObjects = manager.getAllObjects(InventoryItem.self)
		XCTAssertEqual(dbObjects.count, 0)
	}
	
	func testReadAll() {
		let items: [InventoryItem] = buildItems()
		try! manager.add(items)
		let inventoryItems = manager.getAllObjects(InventoryItem.self)
		for i in 0 ..< items.count {
			let readItem = inventoryItems[i]
			let item = items[i]
			XCTAssertEqual(areInventoryItemsEqual(readItem, item), true)
		}
	}
	
	func testReadForPrimaryKey() {
		let item = buildItem(with: "Item 0", price: 0.0)
		try! manager.add(item)
		let dbItem = try! manager.getObject(InventoryItem.self, for: "Item 0")
		XCTAssertEqual(item.price, dbItem.price)
	}
	
	func buildItems() -> [InventoryItem] {
		var items: [InventoryItem] = []
		for i in 1...9 {
			let item = buildItem(with: "Item \(i)", price: Double(i + i))
			items.append(item)
		}
		return items
	}
	
	func testUpdate() {
		let item = buildItem(with: "Item 0", price: 0.0)
		try! manager.add(item)
		let updatedItem = buildItem(with: "Item 0", price: 10.0)
		try! manager.update(from: item, to: updatedItem)
		let dbItems = manager.getAllObjects(InventoryItem.self)
		let dbItem = dbItems.first!
		XCTAssertEqual(dbItem.price, 10.0)
	}
	
	func testUpdateWriteBlock() {
		let item = buildItem(with: "Item 0", price: 0.0)
		try! manager.add(item)
		try! manager.update {
			item.price = 10
		}
		let dbItems = manager.getAllObjects(InventoryItem.self)
		let dbItem = dbItems.first!
		XCTAssertEqual(dbItem.price, 10.0)
	}
	
	func buildItem(with name: String, price: Double) -> InventoryItem {
		let item = InventoryItem()
		item.title = name
		item.price = price
		item.listTitle = "test"
		item.key = item.builtKey
		return item
	}
	
	func areInventoryItemsEqual(_ left: InventoryItem, _ right: InventoryItem) -> Bool {
		return left.title == right.title && left.price == right.price
	}
	
	func testRemoveRealm() {
		try! manager.removeCurrentRealm()
		XCTAssertEqual(Realm.exists(named: RealmManager.testRealm), false)
	}
}
