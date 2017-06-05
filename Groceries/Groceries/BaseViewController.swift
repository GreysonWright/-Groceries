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
		
		navigationItem.title = nil
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
	}
}
