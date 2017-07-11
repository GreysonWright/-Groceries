//
//  Realm+Utilities.swift
//  Groceries
//
//  Created by Greyson Wright on 7/10/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit
import RealmSwift

enum RealmUtilitiesError: Error {
	case directoryDoesNotExist
}

extension Realm {
	static var documentPath: URL? {
		return try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
	}
	
	static func newRealm(named fileName: String) throws -> Realm{
		let realmFileURL = try buildRealmURL(with: fileName)
		var configuration = Realm.Configuration()
//		configuration.deleteRealmIfMigrationNeeded = true
		configuration.fileURL = realmFileURL
		let realm = try Realm(configuration: configuration)
		return realm
	}
	
	static func buildRealmURL(with fileName: String) throws -> URL {
		guard let documentPath = documentPath else {
			throw RealmUtilitiesError.directoryDoesNotExist
		}
		let realmURL = documentPath.appendingPathComponent("\(fileName).realm")
		return realmURL
	}
}
