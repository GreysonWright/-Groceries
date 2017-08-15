//
//  HomeViewController.swift
//  Groceries
//
//  Created by Greyson Wright on 6/3/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
	fileprivate var favorites: [InventoryItem]!
	fileprivate var lists: [ItemList]!
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		title = "Me"
		tabBarItem.image = UIImage.home
		
		cellNibName = "NestedCollectionTableViewCell"
		reuseIdentifier = "NestedCollectionCell"
		
		sections.append(TableViewSection(with: nil))
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadTableViewData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		loadTableViewData()
	}
	
	fileprivate func loadTableViewData() {
		favorites = getFavorites()
		lists = getLists()
		tableView.reloadData()
	}
	
	fileprivate func getFavorites() -> [InventoryItem] {
		guard let manager = try? RealmManager(fileNamed: RealmManager.favoritesRealm) else {
			UIAlertController.showAlert(with: "Could not find realm.", on: self)
			return []
		}
		
		let results = manager.getAllObjects(InventoryItem.self)
		let objects = Array(results)
		return objects
	}
	
	fileprivate func getLists() -> [ItemList] {
		guard let manager = try? RealmManager(fileNamed: RealmManager.listsRealm) else {
			UIAlertController.showAlert(with: "Could not find realm.", on: self)
			return []
		}
		
		let results = manager.getAllObjects(ItemList.self)
		let objects = Array(results)
		return objects
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
		let cell = buildCell(with: tableView, at: indexPath)
		return cell
	}
	
	func buildCell(with tableView: UITableView, at indexPath: IndexPath) -> NestedCollectionTableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NestedCollectionTableViewCell
		if indexPath.row == 0 {
			cell.titleTextLabel.text = "Favorites"
			cell.collectionViewData = buildDataFromFavorites()
		} else {
			cell.titleTextLabel.text = "Lists"
			cell.collectionViewData = buildDataFromLists()
			cell.didSelectCollectionViewCell = didSelectListsCollectionCell
		}
		cell.collectionView.reloadData()
		return cell
	}
	
	fileprivate func didSelectListsCollectionCell(cellData: BaseCollectionViewCellData) {
		guard let listData = cellData.data as? ItemList else {
			return
		}
		let listInventoryViewController = SelectItemViewController(with: listData.title, realm: RealmManager.listsRealm, listItems: Array(listData.inventory))
		navigationController?.pushViewController(listInventoryViewController, animated: true)
	}
	
	fileprivate func buildDataFromFavorites() -> [BaseCollectionViewCellData] {
		let data = favorites.map { (item: InventoryItem) in
			return buildCellData(from: item)
		}
		return data
	}
	
	fileprivate func buildCellData(from item: InventoryItem) -> BaseCollectionViewCellData {
		let cellData = BaseCollectionViewCellData()
		cellData.image = item.image
		cellData.title = item.title
		return cellData
	}
	
	fileprivate func buildDataFromLists() -> [BaseCollectionViewCellData] {
		let data = lists.map { (list: ItemList) in
			return buildCellData(from: list)
		}
		return data
	}
	
	fileprivate func buildCellData(from list: ItemList) -> BaseCollectionViewCellData {
		let cellData = BaseCollectionViewCellData()
		cellData.imageColor = UIColor.primary
		cellData.image = #imageLiteral(resourceName: "List").withRenderingMode(.alwaysTemplate)
		cellData.title = list.title
		cellData.data = list
		return cellData
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		pushViewController(at: indexPath)
	}
	
	func pushViewController(at indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath) as! NestedCollectionTableViewCell
		let controller: UIViewController!
		if indexPath.row == 0 {
			controller = buildFavoritesViewController(with: cell)
		} else {
			controller = buildListViewController(with: cell)
		}
		navigationController?.pushViewController(controller, animated: true)
	}
	
	func buildFavoritesViewController(with cell: NestedCollectionTableViewCell) -> UIViewController{
		let favorites = getFavoritesFromRealm()
		let controller = SelectItemViewController(with: cell.titleTextLabel.text, realm: RealmManager.favoritesRealm, listItems: favorites)
		return controller
	}
	
	func getFavoritesFromRealm() -> [InventoryItem] {
		guard let manager = try? RealmManager(fileNamed: RealmManager.favoritesRealm) else {
			print("Could not find favorites realm.")
			return []
		}
		
		let results = manager.getAllObjects(InventoryItem.self)
		let favorites = Array(results)
		return favorites
	}
	
	func buildListViewController(with cell: NestedCollectionTableViewCell) -> UIViewController{
		let controller = ListsViewController(nibName: "ListsViewController", bundle: nil)
		controller.title = cell.titleTextLabel.text
		return controller
	}
}
