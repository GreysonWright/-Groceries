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
		
		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationController?.navigationBar.shadowImage = UIImage()
		
		let titleView = UIView(frame: CGRect(x: 0, y: 0, width: navigationController!.navigationBar.frame.width, height: 86))
		titleView.backgroundColor = UIColor.red
		navigationItem.titleView = titleView
		
//		titleView.easy_reload()
		
		let label = UILabel()
		label.frame.origin = CGPoint(x: 7, y: 0)
		label.font = UIFont.boldSystemFont(ofSize: 40)
		label.text = title
		label.sizeToFit()
		titleView.addSubview(label)
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		navigationItem.titleView! <- [Edges(0)]
		navigationItem.titleView?.easy_reload()
//		delegate?.rootViewControllerViewDidAppear()
//		navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: navigationController!.navigationBar.frame.width, height: 86)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
