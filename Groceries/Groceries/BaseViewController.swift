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
	var sections: [TableViewSection] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationItem.title = nil
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
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
		return 40
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		headerView.tag = section
		
		let headerTitleLabel = UILabel()
		headerTitleLabel.text = sections[section].title
		headerTitleLabel.sizeToFit()
		headerView.addSubview(headerTitleLabel)
		headerTitleLabel <- [Leading(15), Trailing(0), Top(0), Bottom(0)]
		
		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(headerViewTap(recognizer:)))
		headerView.addGestureRecognizer(tapRecognizer)
		
		return headerView
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath)
		let row = sections[indexPath.section].rows[indexPath.row]
		cell.textLabel?.text = row.title
		return cell
	}
}

// MARK - UIPanGestureRecognizer
extension BaseViewController {
	func headerViewTap(recognizer: UITapGestureRecognizer) {
		let section = recognizer.view!.tag
		sections[section].collapsed = !sections[section].collapsed
		
		tableView.beginUpdates()
		tableView.reloadSections(IndexSet(integer: section), with: .fade)
		tableView.endUpdates()
	}
}
