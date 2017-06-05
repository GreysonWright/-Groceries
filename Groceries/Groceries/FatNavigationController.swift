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
	func navigationControllerPush(_ viewController: UIViewController, animated: Bool)
	func navigationControllerPop(animated: Bool)
	func navigationControllerPopToRoot(animated: Bool)
}

class FatNavigationController: UINavigationController {
	var updaterDelegate: FatNavigationBarDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		updaterDelegate = navigationBar as! FatNavigationBar
		updaterDelegate?.navigationControllerDidLoad(title: viewControllers[0].title)
    }
	
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		super.pushViewController(viewController, animated: animated)
		
		updaterDelegate?.navigationControllerPush(viewController, animated: animated)
	}
	
	override func popViewController(animated: Bool) -> UIViewController? {
		updaterDelegate?.navigationControllerPop(animated: animated)
		return super.popViewController(animated: animated)
	}
	
	override func popToRootViewController(animated: Bool) -> [UIViewController]? {
		updaterDelegate?.navigationControllerPopToRoot(animated: animated)
		return super.popToRootViewController(animated: true)
	}
}
