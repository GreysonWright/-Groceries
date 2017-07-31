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
	fileprivate var titleLabel: UILabel?
	fileprivate var animationLabel: UILabel?
	var title: String?
	var detailTitle: String?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureFlatBarStyle()
	}
	
	func configureFlatBarStyle() {
		isTranslucent = false
		setBackgroundImage(UIImage(), for: .default)
		shadowImage = UIImage()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setup() {
		guard let title = title else { return }
		
		titleLabel = buildTitleLabel(with: title)
		addSubview(titleLabel!)
		titleLabel! <- titleLabelDefaultConstraints
	}
	
	func animateNestedPush() {
		guard let detailTitle = detailTitle else { return }
		
		let animationLabelConstraints = [Trailing(15), Top(frame.height)]
		animationLabel = buildLabel(with: detailTitle, font: UIFont.systemFont(ofSize: 20))
		addAnimationLabelToBar(constraints: animationLabelConstraints)
		prepareAnimationLabelForPush()
		animateWithSpringAndDamping(animations: nestedPushAnimation, completion: nestedPushCompletion)
	}
	
	fileprivate func prepareAnimationLabelForPush() {
		guard let animationLabel = animationLabel else { return }
		animationLabel.font = titleLabel?.font
		animationLabel.easy_clear()
		animationLabel <- [Trailing(15), CenterY(0)]
	}
	
	fileprivate func nestedPushAnimation() {
		titleLabel?.alpha = 0
		animationLabel?.sizeToFit()
		layoutIfNeeded()
	}
	
	fileprivate func nestedPushCompletion(complete: Bool) {
		guard let animationLabel = animationLabel else { return }
		titleLabel?.alpha = 1
		titleLabel?.text = self.animationLabel?.text
		removeLabelFromSuperView(animationLabel)
	}
	
	func animateNestPop() {
		guard let titleLabelText = titleLabel?.text else {
			return
		}
		
		let animationLabelConstraints = [Trailing(15), CenterY(0)]
		animationLabel = buildTitleLabel(with: titleLabelText)
		addAnimationLabelToBar(constraints: animationLabelConstraints)
		prepareTitleLabelForPop()
		prepareAnimationLabelForPop()
		animateWithSpringAndDamping(animations: nestedPopAnimation, completion: nestedPopCompletion)
	}
	
	fileprivate func buildTitleLabel(with title: String) -> UILabel {
		let label = buildLabel(with: title, font: UIFont.boldSystemFont(ofSize: 40))
		label.frame.origin = CGPoint(x: 15, y: 0)
		return label
	}
	
	fileprivate func addAnimationLabelToBar(constraints: [PositionAttribute]) {
		addSubview(animationLabel!)
		animationLabel! <- constraints
		layoutIfNeeded()
	}
	
	fileprivate func prepareTitleLabelForPop() {
		titleLabel?.alpha = 0
		titleLabel?.text = title
	}
	
	fileprivate func prepareAnimationLabelForPop() {
		guard let animationLabel = animationLabel else { return }
		animationLabel.easy_clear()
		animationLabel <- [Trailing(15), Bottom(frame.height)]
	}
	
	fileprivate func nestedPopAnimation() {
		animationLabel?.alpha = 0
		titleLabel?.alpha = 1
		layoutIfNeeded()
	}
	
	fileprivate func nestedPopCompletion(completed: Bool) {
		guard let animationLabel = animationLabel else { return }
		removeLabelFromSuperView(animationLabel)
	}
	
	fileprivate func removeLabelFromSuperView(_ label: UILabel) {
		label.easy_clear()
		label.removeFromSuperview()
	}
	
	fileprivate func buildLabel(with title: String, font: UIFont) -> UILabel {
		let label = UILabel()
		label.text = title
		label.font = font
		label.sizeToFit()
		return label
	}
	
	func animateTitleLabelRight() {
		titleLabel?.text = title
		updateTitleLabelConstraints(titleLabelPushedConstraints)
		animateLayoutIfNeeded(completion: nil)
	}
	
	func animateTitleLabelLeft() {
		titleLabel?.text = title
		updateTitleLabelConstraints(titleLabelDefaultConstraints)
		animateLayoutIfNeeded(completion: nil)
	}
	
	fileprivate func updateTitleLabelConstraints(_ constraints: [PositionAttribute]) {
		titleLabel?.easy_clear()
		titleLabel! <- constraints
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
		titleLabel?.text = title
	}
}
