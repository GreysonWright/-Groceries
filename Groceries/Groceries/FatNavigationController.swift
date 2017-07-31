//
//  FatNavigationController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/4/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class FatNavigationController: UINavigationController, UINavigationControllerDelegate {
	var fatNavigationBar: FatNavigationBar {
		return navigationBar as! FatNavigationBar
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		delegate = self
		fatNavigationBar.set(title: viewControllers.first?.title)
    }
	
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		if viewControllers.count == 1 {
			fatNavigationBar.animateTitleLabelRight()
		} else {
			fatNavigationBar.animateDetailLabelToTitleLabel()
		}
		super.pushViewController(viewController, animated: animated)
	}
	
	override func popViewController(animated: Bool) -> UIViewController? {
		if viewControllers.count < 3 {
			fatNavigationBar.animateTitleLabelLeft()
		}
		return super.popViewController(animated: animated)
	}
	
	override func popToRootViewController(animated: Bool) -> [UIViewController]? {
		fatNavigationBar.animateTitleLabelLeft()
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
				self.fatNavigationBar.popCancelled()
			}
		}
	}
}
