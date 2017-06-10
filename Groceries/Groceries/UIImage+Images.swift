//
//  UIImage+Images.swift
//  Groceries
//
//  Created by Greyson Wright on 6/10/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

extension UIImage {
	open class var selected: UIImage {
		return #imageLiteral(resourceName: "ic_label")
	}
	
	open class var unSelected: UIImage {
		return #imageLiteral(resourceName: "ic_label_outline")
	}
	
	open class var arrowLeft: UIImage {
		return #imageLiteral(resourceName: "ic_keyboard_arrow_left")
	}
	
	open class var arrowRight: UIImage {
		return #imageLiteral(resourceName: "ic_keyboard_arrow_right")
	}
	
	open class var home: UIImage {
		return #imageLiteral(resourceName: "ic_star")
	}
	
	open class var inventory: UIImage {
		return #imageLiteral(resourceName: "ic_shopping_cart")
	}
	
	open class var account: UIImage {
		return #imageLiteral(resourceName: "ic_settings")
	}
}
