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
	var newListAlertTextField: UITextField!
	@IBOutlet weak var newListButton: UIButton!
	fileprivate var selectionCompleted: (() -> (Void))?
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
		
		loadListsIntoTableView()
	}
	
	fileprivate func loadListsIntoTableView() {
		let lists = getListsFromRealm()
		let section = buildSection(with: lists)
		sections = [section]
	}
	
	fileprivate func getListsFromRealm() -> [ItemList] {
		guard let manager = try? RealmManager(fileNamed: RealmManager.listsRealm) else {
			print("Couldn't find lists realm.")
			return []
		}
		let listInventory = manager.getAllObjects(ItemList.self)
		return Array(listInventory)
	}

	fileprivate func buildSection(with lists: [ItemList]) -> TableViewSection {
		let section = TableViewSection(with: nil, rowData: lists)
		section.collapsed = false
		section.collapsible = false
		return section
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}
	
	func addToUserDefinedList(inventory: [InventoryItem], target: UIViewController, navigationController: UINavigationController?, completed: (() -> Void)?) {
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

//MARK: -UIButton
extension ListsViewController {
	@IBAction func newListButtonTapped(_ sender: Any) {
		showNewListAlert()
	}
	
	fileprivate func createListActionTapped(alertAction: UIAlertAction) {
		let listTitle = newListAlertTextField.text!
		guard !listTitle.isEmpty else {
			UIAlertController.showAlert(with: "Please provide a list name.", on: self, dismiss: { (action: UIAlertAction) in
				self.showNewListAlert()
			})
			return
		}
		
		guard !listExists(named: listTitle, realmName: RealmManager.listsRealm) else {
			UIAlertController.showAlert(with: "A list with that name already exists.", on: self, dismiss: { (action: UIAlertAction) in
				self.showNewListAlert()
			})
			return
		}
		
		let newList = buildNewList(with: listTitle)
		write(newList, to: RealmManager.listsRealm)
		loadListsIntoTableView()
		tableView.reloadData()
	}
	
	fileprivate func showNewListAlert() {
		let newListAlertController = buildNewListAlertController()
		present(newListAlertController, animated: true, completion: nil)
	}
	
	fileprivate func buildNewListAlertController() -> UIAlertController {
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		let createListAction = UIAlertAction(title: "Create", style: .default, handler: createListActionTapped)
		
		let alertController = UIAlertController(title: "New List", message: nil, preferredStyle: .alert)
		alertController.addTextField(configurationHandler: configureAlertControllerTextField)
		alertController.addAction(cancelAction)
		alertController.addAction(createListAction)
		return alertController
	}
	
	fileprivate func configureAlertControllerTextField(textField: UITextField) {
		textField.placeholder = "List Name"
		newListAlertTextField = textField
	}
	
	fileprivate func buildNewList(with title: String) -> ItemList {
		let newList = ItemList()
		newList.title = title
		return newList
	}
	
	fileprivate func write(_ list: ItemList, to realmName: String) {
		do {
			let manager = try RealmManager(fileNamed: realmName)
			try manager.add(list)
		} catch {
			print("Couldn't create new list.")
			UIAlertController.showAlert(with: "Could not create list.", on: self)
		}
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
			writeUpdate(for: rowData, to: RealmManager.listsRealm)
			tableView.reloadData()
			dismiss(animated: true, completion: selectionCompleted)
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func pushToSelectViewController(with rowData: ItemList, at indexPath: IndexPath) {
		let listInventoryViewController = SelectItemViewController(with: rowData.title, realm: RealmManager.listsRealm, listItems: Array(rowData.inventory))
		navigationController?.pushViewController(listInventoryViewController, animated: true)
	}
	
	fileprivate func listExists(named title: String, realmName: String) -> Bool {
		do {
			let manager = try RealmManager(fileNamed: realmName)
			let list = try? manager.getObject(ItemList.self, for: title)
			return list != nil
		} catch {
			fatalError("Realm not found")
		}
		return true
	}
	
	fileprivate func writeUpdate(for itemList: ItemList, to realmName: String) {
		do {
			let manager = try RealmManager(fileNamed: realmName)
			try manager.update {
				newInentory?.forEach({ (item: InventoryItem) in
					item.listTitle = itemList.title
					item.generatePrimaryKey()
					itemList.inventory.append(item)
				})
				itemList.calculateTotalPrice()
			}
		} catch {
			print("Could not update object.")
		}
	}
}
