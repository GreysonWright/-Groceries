//
//  RealmManager+Realms.swift
//  Groceries
//
//  Created by Greyson Wright on 7/12/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

extension RealmManager {
	static var favoritesRealm: String {
		return "Favorites"
	}
	
	static var listsRealm: String {
		return "Lists"
	}
	
	static var accountSettingsRealm: String {
		return "AccountSettings"
	}
	
	static var testRealm: String {
		return "Test"
	}
}
