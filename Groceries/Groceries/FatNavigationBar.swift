//
//  FatNavigationBar.swift
//  Groceries
//
//  Created by Greyson Wright on 6/4/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit
import EasyPeasy

class FatNavigationBar: UINavigationBar, FatNavigationControllerDelegate {
	var titleLabel: UILabel?
//	var detailLabel: UILabel?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configureFlatStyle()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
//	override func sizeThatFits(_ size: CGSize) -> CGSize {
//		return CGSize(width: UIScreen.main.bounds.width, height: 86)
//	}
	
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
}

// MARK: - FatNavigationController
extension FatNavigationBar {
	func configureLabel(title: String) {
		titleLabel = UILabel()
		titleLabel!.frame.origin = CGPoint(x: 15, y: 0)
		titleLabel!.font = UIFont.boldSystemFont(ofSize: 40)
		titleLabel!.text = title
		titleLabel!.sizeToFit()
		addSubview(titleLabel!)
	}
	
	func navigationControllerPush(_ viewController: UIViewController, animated: Bool) {
		animateTitleLabelRight()
	}
	
	fileprivate func animateTitleLabelRight() {
		UIView.animate(withDuration: 0.36, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .layoutSubviews, animations: {
			self.titleLabel?.frame.origin = CGPoint(x: UIScreen.main.bounds.width - self.titleLabel!.frame.width - 15, y: 0)
		}, completion: nil)
	}
	
	func navigationControllerPop(animated: Bool) {
		animateTitleLabelLeft()
	}
	
	fileprivate func animateTitleLabelLeft() {
		UIView.animate(withDuration: 0.36, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .layoutSubviews, animations: {
			self.titleLabel?.frame.origin = CGPoint(x: 15, y: 0)
		}, completion: nil)
	}
	
	func popCancelled() {
		titleLabel?.frame.origin = CGPoint(x: UIScreen.main.bounds.width - self.titleLabel!.frame.width - 15, y: 0)
	}
	
	func navigationControllerPopToRoot(animated: Bool) {
		// needs st00f
	}
}
