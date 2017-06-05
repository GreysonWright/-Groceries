//
//  FatNavigationBar.swift
//  Groceries
//
//  Created by Greyson Wright on 6/4/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit
import EasyPeasy

class FatNavigationBar: UINavigationBar, FatNavigationBarDelegate {
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configureFlatStyle()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func sizeThatFits(_ size: CGSize) -> CGSize {
		return CGSize(width: UIScreen.main.bounds.width, height: 86)
	}
	
	func navigationControllerDidLoad(title: String?) {
		guard let title = title else {
			return
		}
		
		configureLabel(title: title)
	}
	
	func configureFlatStyle() {
		isTranslucent = false
		setBackgroundImage(UIImage(), for: .default)
		shadowImage = UIImage()
	}
	
	func configureLabel(title: String) {
		let label = UILabel()
		label.frame.origin = CGPoint(x: 0, y: 0)
		label.font = UIFont.boldSystemFont(ofSize: 40)
		label.text = title
		label.sizeToFit()
		addSubview(label)
		label <- [Leading(15), Top(0)]
	}
}
