//
//  HomeViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/3/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		title = "Me"
		tabBarItem.image = UIImage.home
		
		cellNibName = "NestedCollectionTableViewCell"
		reuseIdentifier = "NestedCollectionCell"
		
		sections.append(TableViewSection(with: nil))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - UITableView
extension HomeViewController {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 207
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NestedCollectionTableViewCell
		if indexPath.row == 0 {
			cell.titleLabel.text = "Favorites"
		} else {
			cell.titleLabel.text = "Lists"
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath) as! NestedCollectionTableViewCell
		let controller = ListsViewController(nibName: "ListsViewController", bundle: nil)
		controller.title = cell.titleLabel.text
		navigationController?.pushViewController(controller, animated: true)
	}
}
