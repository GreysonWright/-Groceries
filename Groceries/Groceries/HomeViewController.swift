//
//  HomeViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/3/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var tableView: UITableView!
	let cellNibName = "NestedCollectionTableViewCell"
	let reuseIdentifier = "NestedCollectionCell"
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		title = "Me"
		tabBarItem.image = #imageLiteral(resourceName: "ic_star")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.register(nib: cellNibName, forCellReuseIdentifier: reuseIdentifier)
//		let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//		label.text = "test"
//		navigationItem.titleView = nil
    }

	
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableView
extension HomeViewController {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 207
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NestedCollectionTableViewCell
		cell.titleLabel.text = "Favorites"
		return cell
	}
}
