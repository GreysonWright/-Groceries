//
//  ListsViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/12/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

fileprivate enum ListsViewControllerMode {
	case normal
	case selectList
}

class ListsViewController: BaseViewController {
	fileprivate var selectionCompleted: ((Bool) -> (Void))?
	fileprivate var newInentory: [InventoryItem]?
	fileprivate var mode: ListsViewControllerMode {
		if newInentory == nil {
			return .normal
		}
		return .selectList
	}
	
	convenience init(with title: String?) {
		self.init(nibName: "ListsViewController", bundle: nil)
		self.title = title
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		cellNibName = "ListTableViewCell"
		reuseIdentifier = "ListCell"
		
		let lists = getListsFromRealm()
		let section1 = TableViewSection(with: nil, rowData: lists)
		section1.collapsed = false
		section1.collapsible = false
		sections.append(section1)
	}
	
	func getListsFromRealm() -> [ItemList] {
		guard let manager = try? RealmManager(fileNamed: RealmManager.listsRealm) else {
			print("Couldn't find lists realm.")
			return []
		}
		let listInventory = manager.getAllObjects(ItemList.self)
		return Array(listInventory)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func addToUserDefinedList(inventory: [InventoryItem], target: UIViewController, navigationController: UINavigationController?, completed: ((Bool) -> Void)?) {
		newInentory = inventory
		guard let navigationController = navigationController else {
			target.present(self, animated: true, completion: nil)
			return
		}
		navigationController.viewControllers.append(self)
		target.present(navigationController, animated: true, completion: nil)
		selectionCompleted = completed
	}
}

// MARK: - UITableView
extension ListsViewController {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 48
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = sections[indexPath.section].rows[indexPath.row]
		let rowData = row.data as! ItemList
		
		let cell = super.tableView(tableView, cellForRowAt: indexPath) as! ListTableViewCell
		cell.titleTextLabel.text = rowData.title
		cell.priceTextLabel.text = String(format: "$%.2lf", rowData.totalPrice)
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let row = sections[indexPath.section].rows[indexPath.row]
		let rowData = row.data as! ItemList
		if mode == .normal {
			pushToSelectViewController(with: rowData, at: indexPath)
		} else {
			let updatedRowData = rowData
			newInentory?.forEach({ (item: InventoryItem) in
				updatedRowData.inventory.append(item)
			})
			writeUpdate(rowData, realm: RealmManager.listsRealm)
			dismiss(animated: true, completion: nil)
		}
		tableView.deselectRow(at: indexPath, animated: true)
		selectionCompleted?(true)
	}
	
	func pushToSelectViewController(with rowData: ItemList, at indexPath: IndexPath) {
		let listInventoryViewController = SelectItemViewController(with: rowData.title, listItems: Array(rowData.inventory))
		navigationController?.pushViewController(listInventoryViewController, animated: true)
	}
	
	func writeUpdate(_ itemList: ItemList, realm realmName: String) {
		do {
			let manager = try RealmManager(fileNamed: realmName)
			try manager.updatingAdd(itemList)
		} catch {
			print("Could not update object.")
		}
	}
}
