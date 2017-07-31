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
	fileprivate var titleLabelDefaultConstraints: [PositionAttribute] {
		return [Leading(15), CenterY(0), Trailing(>=15)]
	}
	fileprivate var titleLabelPushedConstraints: [PositionAttribute] {
		return [Leading(>=15), CenterY(0), Trailing(15)]
	}
	var titleLabel: UILabel?
	var title: String?
	var detailTitle: String?
	
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
		titleLabel! <- titleLabelDefaultConstraints
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
		updateTitleLabelConstraints(titleLabelPushedConstraints)
		animateLayoutIfNeeded(completion: nil)
	}
	
	func animateTitleLabelLeft() {
		updateTitleLabelConstraints(titleLabelDefaultConstraints)
		animateLayoutIfNeeded(completion: nil)
	}
	
	func updateTitleLabelConstraints(_ constraints: [PositionAttribute]) {
		titleLabel?.easy_clear()
		titleLabel! <- constraints
	}
	
	func animateDetailLabelToTitleLabel() {
		let animationLabel = buildLabel(with: detailTitle!, font: UIFont.systemFont(ofSize: 20))
		addSubview(animationLabel)
		animationLabel <- [Trailing(15), Top(frame.height)]
		layoutIfNeeded()
		
		animationLabel.font = self.titleLabel?.font
		animationLabel.easy_clear()
		animationLabel <- [Trailing(15), CenterY(0)]
		
		animateWithSpringAndDamping(animations: { 
			self.titleLabel?.alpha = 0
			animationLabel.sizeToFit()
			self.layoutIfNeeded()
		}) { (completed: Bool) in
			self.titleLabel?.alpha = 1
			self.titleLabel?.text = animationLabel.text
			animationLabel.easy_clear()
			animationLabel.removeFromSuperview()
		}
	}
	
	fileprivate func animateLayoutIfNeeded(completion: ((Bool) -> Void)?) {
		animateWithSpringAndDamping(animations: { 
			self.layoutIfNeeded()
		}, completion: nil)
	}
	
	fileprivate func animateWithSpringAndDamping(animations: @escaping (() -> Void), completion: ((Bool) -> Void)?) {
		UIView.animate(withDuration: 0.36, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .layoutSubviews, animations: animations, completion: completion)
	}
	
	func popCancelled() {
		updateTitleLabelConstraints(titleLabelPushedConstraints)
	}
}
