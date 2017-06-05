//
//  BaseViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/4/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit
import EasyPeasy

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
	
		configureNavBar()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
	}
	
	// Unfortunately this is the cleanest way i could figure out how to do this
	func configureNavBar() {
		navigationItem.title = ""
//		let titleView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 86))
//		titleView.backgroundColor = UIColor.navBarBackground
//		navigationController?.navigationBar.addSubview(titleView)
//		titleView <- Edges(0)
//		(navigationController?.navigationBar as! FatNavigationBar).backgroundView = titleView
		
//		let label = UILabel()
//		label.frame.origin = CGPoint(x: 0, y: 0)
//		label.font = UIFont.boldSystemFont(ofSize: 40)
//		label.text = title
//		label.sizeToFit()
//		navigationController?.navigationBar.addSubview(label)
//		label <- [Leading(15), Top(0)]
//		(navigationController?.navigationBar as! FatNavigationBar).titleView = label
	}
}
