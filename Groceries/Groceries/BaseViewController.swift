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
	@IBOutlet weak var titleLabel: UILabel?
	@IBOutlet weak var tableView: UITableView!
	var cellNibName = "BaseTableViewCell"
	var reuseIdentifier = "BaseCell"
	var sections: [TableViewSection] = []
	var titleLabelHidden = false
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		extendedLayoutIncludesOpaqueBars = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationItem.title = nil
		
		tableView.register(nib: cellNibName, forCellReuseIdentifier: reuseIdentifier)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		titleLabel?.isHidden = titleLabelHidden
		titleLabel?.text = title
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.395) {
			self.titleLabel?.font =  UIFont.italicSystemFont(ofSize: 20)
		}
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
		let headerView = buildHeaderView(with: section)
		return headerView
	}
	
	func buildHeaderView(with section: Int) -> UIView {
		let headerView = initView(with: section)
		
		let headerTitleLabel = buildHeaderTitleLabel(with: sections[section].title)
		headerView.addSubview(headerTitleLabel)
		headerTitleLabel <- [Leading(15), Trailing(0), Top(0), Bottom(0)]
		
		guard sections[section].collapsible else {
			return headerView
		}
		
		addTapRecognizer(to: headerView)
		
		return headerView
	}
	
	func initView(with section: Int) -> UIView {
		let view = UIView()
		view.backgroundColor = UIColor.white
		view.tag = section
		return view
	}
	
	func buildHeaderTitleLabel(with title: String?) -> UILabel {
		let label = UILabel()
		label.text = title
		label.font = UIFont.boldSystemFont(ofSize: 25)
		label.sizeToFit()
		return label
	}
	
	func addTapRecognizer(to view: UIView) {
		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(headerViewTap(recognizer:)))
		view.addGestureRecognizer(tapRecognizer)
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
