//
//  FatNavigationBar.swift
//  Groceries
//
//  Created by Greyson Wright on 6/4/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit
import EasyPeasy

class FatNavigationBar: UINavigationBar {
	var titleLabel: UILabel?
	var title: String?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configureFlatStyle()
	}
	
	func configureFlatStyle() {
		isTranslucent = false
		setBackgroundImage(UIImage(), for: .default)
		shadowImage = UIImage()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func set(title: String?) {
		self.title = title
		guard let title = title else {
			return
		}
		
		titleLabel = buildTitleLabel(with: title)
		addSubview(titleLabel!)
	}
	
	func buildTitleLabel(with title: String) -> UILabel {
		let label = buildLabel(with: title, font: UIFont.boldSystemFont(ofSize: 40))
		label.frame.origin = CGPoint(x: 15, y: 0)
		return label
	}
	
	func buildLabel(with title: String, font: UIFont) -> UILabel {
		let label = UILabel()
		label.text = title
		label.font = font
		label.sizeToFit()
		return label
	}
	
	func animateTitleLabelRight() {
		let newOrigin = CGPoint(x: UIScreen.main.bounds.width - self.titleLabel!.frame.width - 15, y: 0)
		animateTitleLabel(to: newOrigin)
	}
	
	func animateTitleLabelLeft() {
		let newOrigin = CGPoint(x: 15, y: 0)
		animateTitleLabel(to: newOrigin)
	}
	
	fileprivate func animateTitleLabel(to point: CGPoint) {
		UIView.animate(withDuration: 0.36, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .layoutSubviews, animations: {
			self.titleLabel?.frame.origin = point
		}, completion: nil)
	}
	
	func animateDetailLabelToTitleLabel() {
		let animationLabel = buildLabel(with: title!, font: UIFont.systemFont(ofSize: 20))
		animationLabel.frame.origin = CGPoint(x: UIScreen.main.bounds.width - animationLabel.frame.width - 18, y: frame.height)
		addSubview(animationLabel)
	}
	
	func popCancelled() {
		titleLabel?.frame.origin = CGPoint(x: UIScreen.main.bounds.width - self.titleLabel!.frame.width - 15, y: 0)
	}
}
