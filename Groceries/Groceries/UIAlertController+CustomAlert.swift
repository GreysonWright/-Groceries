//
//  UIAlertController+CustomAlert.swift
//  Groceries
//
//  Created by Greyson Wright on 7/14/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

extension UIAlertController {
	static func showAlert(with message: String?, on viewController: UIViewController) {
		showAlert(with: nil, message: message, on: viewController)
	}
	
	static func showAlert(with message: String?, on viewController: UIViewController, dismiss: ((UIAlertAction) -> Void)?) {
		showAlert(with: nil, message: message, on: viewController, dismiss: dismiss)
	}
	
	static func showAlert(with title: String?, message: String?, on viewController: UIViewController) {
		showAlert(with: title, message: message, on: viewController, dismiss: nil)
	}
	
	static func showAlert(with title: String?, message: String?, on viewController: UIViewController, dismiss: ((UIAlertAction) -> Void)?) {
		let okAlertAction = UIAlertAction(title: "Ok", style: .default, handler: dismiss)
		let alertController = buildAlertController(with: title, message: message)
		alertController.addAction(okAlertAction)
		viewController.present(alertController, animated: true, completion: nil)
	}
	
	static func showAlert(with message: String?, actions: [UIAlertAction], on viewController: UIViewController) {
		showAlert(with: nil, message: message, actions: actions, on: viewController)
	}
	
	static func showAlert(with title: String?, message: String?, actions: [UIAlertAction], on viewController: UIViewController) {
		let alertController = buildAlertController(with: title, message: message)
		actions.forEach { (action: UIAlertAction) in
			alertController.addAction(action)
		}
		viewController.present(alertController, animated: true, completion: nil)
	}
	
	static func showAlert(with duration: DispatchTimeInterval, message: String?, on viewController: UIViewController) {
		showAlert(with: duration, title: nil, message: message, on: viewController)
	}
	
	static func showAlert(with duration: DispatchTimeInterval, title: String?, message: String?, on viewController: UIViewController) {
		let alertController = buildAlertController(with: title, message: message)
		viewController.present(alertController, animated: true, completion: nil)
		DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
			alertController.dismiss(animated: true, completion: nil)
		}
	}
	
	fileprivate static func buildAlertController(with title: String?, message: String?) -> UIAlertController {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		return alertController
	}
}
