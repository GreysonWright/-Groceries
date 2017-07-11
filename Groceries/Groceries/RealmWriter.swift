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
	
	init() throws {
		currentRealm = nil
	}
	
	init(fileName: String) throws {
		let realmURL = try Realm.buildRealmURL(with: fileName)
		do {
			currentRealm = try Realm(fileURL: realmURL)
		} catch {
			throw RealmWriterError.fileDoesNotExist
		}
	}
	
	func createRealm(named fileName: String) throws {
		currentRealm = try Realm.newRealm(named: fileName)
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
