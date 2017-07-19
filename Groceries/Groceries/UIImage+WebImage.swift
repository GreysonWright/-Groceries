//
//  UIImage+WebImage.swift
//  Groceries
//
//  Created by Greyson Wright on 7/19/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

extension UIImage {
	static func image(from urlString: String) -> UIImage {
		guard let imageURL = URL(string: urlString) else {
			return errorImage()
		}
		guard let imageData = try? Data(contentsOf: imageURL) else {
			return errorImage()
		}
		guard let resultImage = UIImage(data: imageData) else {
			return errorImage()
		}
		return resultImage
	}
	
	static fileprivate func errorImage() -> UIImage {
		print("No image at url.")
		return #imageLiteral(resourceName: "ic_photo")
	}
}
