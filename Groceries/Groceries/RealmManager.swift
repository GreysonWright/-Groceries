//
//  RealmWriter.swift
//  Groceries
//
//  Created by Greyson Wright on 7/10/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit
import RealmSwift

enum RealmManagerError: Error {
	case primaryKeyNotFound
}

class RealmManager {
	fileprivate var realm: Realm!
	fileprivate var realmName: String!
	
	init() throws {
		realm = try Realm()
		realmName = "default"
	}
	
	init(fileNamed name: String) throws {
		let realmURL = try Realm.buildRealmURL(with: name)
		realm = try Realm(fileURL: realmURL)
		realmName = name
	}
	
	func removeCurrentRealm() throws {
		try Realm.remove(named: realmName)
	}
	
	func add(_ object: Object) throws {
		try add(object, update: false)
	}
	
	func updatingAdd(_ object: Object) throws {
		try add(object, update: true)
	}
	
	fileprivate func add(_ object: Object, update: Bool) throws {
		try realm.write {
			realm.add(object, update: update)
		}
	}
	
	func add(_ objects: [Object]) throws {
		try add(objects, update: false)
	}

	func updatingAdd(_ objects: [Object]) throws {
		try add(objects, update: true)
	}
	
	fileprivate func add(_ objects: [Object], update: Bool) throws {
		try realm.write {
			objects.forEach({ (object: Object) in
				realm.add(object, update: update)
			})
		}
	}
	
	func update(from old: Object, to new: Object) throws {
		try realm.write {
			realm.delete(old)
			realm.add(new)
		}
	}
	
	func update(write: (() throws -> Void)) throws {
		try realm.write {
			try write()
		}
	}
	
	func getAllObjects<T>(_ type: T.Type) -> Results<T> {
		return realm.objects(type)
	}
	
	func getObject<T: Object, K>(_ type: T.Type, for primaryKey: K) throws -> T {
		guard let dbResult = realm.object(ofType: type, forPrimaryKey: primaryKey) else {
			throw RealmManagerError.primaryKeyNotFound
		}
		return dbResult
	}
	
	func delete(_ object: Object) throws {
		try realm.write {
			realm.delete(object)
		}
	}
	
	func delete(_ objects: [Object]) throws {
		try realm.write {
			objects.forEach({ (object: Object) in
				realm.delete(object)
			})
		}
	}
	
	func deleteAll() throws {
		try realm.write {
			realm.deleteAll()
		}
	}
}
