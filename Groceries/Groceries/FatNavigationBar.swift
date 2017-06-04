//
//  FatNavigationBar.swift
//  Groceries
//
//  Created by Greyson Wright on 6/4/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class FatNavigationBar: UINavigationBar {
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func sizeThatFits(_ size: CGSize) -> CGSize {
		return CGSize(width: UIScreen.main.bounds.size.width, height: 86)
	}
}
