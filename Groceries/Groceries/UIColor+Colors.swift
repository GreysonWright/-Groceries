//
//  UIColor+Colors.swift
//  Groceries
//
//  Created by Greyson Wright on 6/4/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

extension UIColor {
	open class var primary: UIColor {
		return UIColor(red: 74 / 255, green: 73 / 255, blue: 71 / 255, alpha: 1)
	}
	
	open class var secondary: UIColor {
		return UIColor(red: 98 / 255, green: 160 / 255, blue: 93 / 255, alpha: 1)
	}
	
	open class var accent1: UIColor {
		return UIColor(red: 119 / 255, green: 122 / 255, blue: 127 / 255, alpha: 1)
	}
	
	open class var accent2: UIColor {
		return UIColor(red: 140 / 255, green: 178 / 255, blue: 138 / 255, alpha: 1)
	}
	
	open class var accent3: UIColor {
		return UIColor(red: 179 / 255, green: 183 / 255, blue: 188 / 255, alpha: 1)
	}
	
	open class var sectionTitle: UIColor {
		return accent2
	}
	
	open class var viewControllerTitle: UIColor {
		return accent2
	}
	
	open class var tabBarBackground: UIColor {
		return secondary
	}
	
	open class var tabBarTint: UIColor {
		return white
	}
	
	open class var tabBarUnselectedTint: UIColor {
		return accent3
	}
	
	open class var navBarForeground: UIColor {
		return secondary
	}
	
	open class var navBarBackground: UIColor {
		return UIColor.white
	}
}
