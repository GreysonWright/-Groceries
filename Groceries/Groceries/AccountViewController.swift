//
//  AccountViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/3/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class AccountViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var tableView: UITableView!
	let cellNibName = "BaseTableViewCell"
	let reuseIdentifier = "BaseCell"
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		title = "Account"
		tabBarItem.image = #imageLiteral(resourceName: "ic_settings")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.register(nib: cellNibName, forCellReuseIdentifier: reuseIdentifier)
	}
}

// MARK: - UITableView
extension AccountViewController {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
		return cell
	}
}

