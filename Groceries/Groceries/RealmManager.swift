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
	case fileDoesNotExist
	case nilRealm
	case nilObjectForKey
}

class RealmManager {
	fileprivate var currentRealm: Realm?
	var realm: Realm {
		guard let currentRealm = self.currentRealm else {
			return defaultRealm
		}
		return currentRealm
	}
	var defaultRealm: Realm {
		return try! Realm()
	}
	
	init() {
		currentRealm = nil
	}
	
	init(fileName: String) throws {
		let realmURL = try Realm.buildRealmURL(with: fileName)
		do {
			currentRealm = try Realm(fileURL: realmURL)
		} catch {
			throw RealmManagerError.fileDoesNotExist
		}
	}
	
	func createRealm(named fileName: String) throws {
		currentRealm = try Realm.newRealm(named: fileName)
	}
	
	func removeRealm(named fileName: String) throws {
		let realmURL = try Realm.buildRealmURL(with: fileName)
		try FileManager.default.removeItem(at: realmURL)
	}
	
	func add(object: Object) throws {
		do {
			try realm.write {
				realm.add(object)
			}
		} catch {
			throw RealmManagerError.nilRealm
		}
	}
	
	func add(objects: [Object]) throws {
		do {
			try realm.write {
				objects.forEach({ (object: Object) in
					realm.add(object)
				})
			}
		} catch {
			throw RealmManagerError.nilRealm
		}
	}
	
	func getAllObjects<T>(_ type: T.Type) -> Results<T> {
		return realm.objects(type)
	}
		
	func delete(object: Object) throws {
		do {
			try realm.write {
				realm.delete(object)
			}
		} catch {
			throw RealmManagerError.nilRealm
		}
	}
	
	func deleteAll() throws {
		do {
			try realm.write {
				realm.deleteAll()
			}
		} catch {
			throw RealmManagerError.nilRealm
		}
	}
}
