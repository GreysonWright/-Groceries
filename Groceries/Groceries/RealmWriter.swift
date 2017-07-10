//
//  RealmWriter.swift
//  Groceries
//
//  Created by Greyson Wright on 7/10/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit
import RealmSwift

enum RealmWriterError: Error {
	case fileDoesNotExist
	case nilRealm
}

class RealmWriter {
	fileprivate var realm: Realm!
	
	init() throws {
		realm = try Realm()
	}
	
	init(fileName: String) throws {
		let realmURL = try Realm.buildRealmURL(with: fileName)
		do {
			realm = try Realm(fileURL: realmURL)
		} catch {
			throw RealmWriterError.fileDoesNotExist
		}
	}
	
	func createRealm(named fileName: String) throws {
		realm = try Realm.newRealm(named: fileName)
	}
	
	func removeRealm(named fileName: String) throws {
		let realmURL = try Realm.buildRealmURL(with: fileName)
		try FileManager.default.removeItem(at: realmURL)
	}
	
	func write(object: Object) throws {
		do {
			try realm.write {
				realm.add(object)
			}
		} catch {
			throw RealmWriterError.nilRealm
		}
	}
	
	func remove(object: Object) throws {
		do {
			try realm.write {
				realm.delete(object)
			}
		} catch {
			throw RealmWriterError.nilRealm
		}
	}
}
