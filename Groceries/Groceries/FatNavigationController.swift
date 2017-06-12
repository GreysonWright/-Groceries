//
//  FatNavigationController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/4/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit
import EasyPeasy

@objc protocol FatNavigationControllerDelegate {
	@objc optional func navigationControllerDidLoad(title: String?)
	@objc optional func navigationControllerPush(_ viewController: UIViewController, animated: Bool)
	@objc optional func navigationControllerPop(animated: Bool)
	@objc optional func navigationControllerPopToRoot(animated: Bool)
	@objc optional func popCancelled()
}

class FatNavigationController: UINavigationController, UINavigationControllerDelegate {
	var updaterDelegate: FatNavigationControllerDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		delegate = self
		updaterDelegate = navigationBar as! FatNavigationBar
		updaterDelegate?.navigationControllerDidLoad?(title: viewControllers[0].title)
    }
	
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		super.pushViewController(viewController, animated: animated)
		updaterDelegate?.navigationControllerPush?(viewController, animated: animated)
	}
	
	override func popViewController(animated: Bool) -> UIViewController? {
		updaterDelegate?.navigationControllerPop?(animated: animated)
		return super.popViewController(animated: animated)
	}
	
	override func popToRootViewController(animated: Bool) -> [UIViewController]? {
		updaterDelegate?.navigationControllerPopToRoot?(animated: animated)
		return super.popToRootViewController(animated: true)
	}
	
	func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
		transitionCoordinator?.notifyWhenInteractionEnds { context in
			guard context.isCancelled, let fromViewController = context.viewController(forKey: UITransitionContextViewControllerKey.from) else {
				return
			}
			
			self.navigationController(self, willShow: fromViewController, animated: animated)
			let animationCompletion: TimeInterval = context.transitionDuration * Double(context.percentComplete)
			DispatchQueue.main.asyncAfter(deadline: .now() + animationCompletion) {
				self.updaterDelegate?.popCancelled?()
			}
		}
	}
}
