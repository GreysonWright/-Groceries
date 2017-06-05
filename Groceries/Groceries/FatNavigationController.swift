//
//  FatNavigationController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/4/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit
import EasyPeasy

protocol FatNavigationBarDelegate {
	func navigationControllerDidLoad(title: String?)
}

class FatNavigationController: UINavigationController {
	var updaterDelegate: FatNavigationBarDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		updaterDelegate = navigationBar as! FatNavigationBar
		updaterDelegate?.navigationControllerDidLoad(title: viewControllers[0].title)
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
	}
	
	override func popViewController(animated: Bool) -> UIViewController? {
		return super.popViewController(animated: animated)
	}
}
