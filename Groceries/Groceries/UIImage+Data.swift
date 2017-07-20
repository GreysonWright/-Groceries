//
//  UIImage+Data.swift
//  Groceries
//
//  Created by Greyson Wright on 7/20/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

extension UIImage {
	var data: Data? {
		return UIImagePNGRepresentation(self)
	}
	
	var base64EncodedString: String? {
		let imageData = data
		guard let dataString = imageData?.base64EncodedString() else {
			return nil
		}
		return dataString
	}
}
