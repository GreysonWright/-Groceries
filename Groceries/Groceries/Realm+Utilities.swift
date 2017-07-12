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
	
	static func exists(named name: String) -> Bool {
		guard let filePath = try? buildRealmURL(with: name).path else {
			return false
		}
		return FileManager.default.fileExists(atPath: filePath)
	}
	
	static func remove(named name: String) throws {
		let realmURL = try buildRealmURL(with: name)
		try FileManager.default.removeItem(at: realmURL)
	}
	
	static func buildRealmURL(with fileName: String) throws -> URL {
		guard let documentPath = documentPath else {
			throw RealmUtilitiesError.directoryDoesNotExist
		}
		let realmURL = documentPath.appendingPathComponent("\(fileName).realm")
		return realmURL
	}
}
