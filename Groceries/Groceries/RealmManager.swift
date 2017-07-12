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
	fileprivate var realm: Realm!
	fileprivate var realmName: String!
	
	init() throws {
		realm = try Realm()
		realmName = "default"
	}
	
	init(fileNamed name: String) throws {
		let realmURL = try Realm.buildRealmURL(with: name)
		do {
			realm = try Realm(fileURL: realmURL)
			realmName = name
		} catch {
			throw RealmManagerError.fileDoesNotExist
		}
	}
	
	func removeCurrentRealm() throws {
		try Realm.remove(named: realmName)
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
