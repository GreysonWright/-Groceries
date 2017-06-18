//
//  BaseViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/4/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit
import EasyPeasy

class BaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var tableView: UITableView!
	var cellNibName = "BaseTableViewCell"
	var reuseIdentifier = "BaseCell"
	var sections: [TableViewSection] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationItem.title = nil
		
		tableView.register(nib: cellNibName, forCellReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - UITableView
extension BaseViewController {
	func numberOfSections(in tableView: UITableView) -> Int {
		return sections.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if !sections[section].collapsed {
			return sections[section].rowCount
		}
		
		return 0
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if sections[section].title != nil {
			return 40
		}
		
		return 0
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		headerView.backgroundColor = UIColor.white
		headerView.tag = section
		
		let headerTitleLabel = UILabel()
		headerTitleLabel.text = sections[section].title
		headerTitleLabel.font = UIFont.boldSystemFont(ofSize: 25)
		headerTitleLabel.sizeToFit()
		headerView.addSubview(headerTitleLabel)
		headerTitleLabel <- [Leading(15), Trailing(0), Top(0), Bottom(0)]
		
		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(headerViewTap(recognizer:)))
		headerView.addGestureRecognizer(tapRecognizer)
		
		return headerView
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
		return cell
	}
}

// MARK - UIPanGestureRecognizer
extension BaseViewController {
	func headerViewTap(recognizer: UITapGestureRecognizer) {
		let sectionIndex = recognizer.view!.tag
		sections[sectionIndex].collapsed = !sections[sectionIndex].collapsed
		
		tableView.beginUpdates()
		tableView.reloadSections(IndexSet(integer: sectionIndex), with: .fade)
		tableView.endUpdates()
	}
}
