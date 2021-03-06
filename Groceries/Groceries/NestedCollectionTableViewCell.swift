//
//  NestedCollectionTableViewCell.swift
//  Groceries
//
//  Created by Greyson Wright on 6/3/17.
//  Copyright © 2017 Greyson Wright. All rights reserved.
//

import UIKit

class NestedCollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var titleTextLabel: UILabel!
	@IBOutlet weak var titleDetailImageView: UIImageView!
	fileprivate let collectionCellNibName = "BaseCollectionViewCell"
	fileprivate let collectionReuseIdentifier = "BaseCollectionCell"
	var collectionViewData: [BaseCollectionViewCellData]!
	var didSelectCollectionViewCell: ((BaseCollectionViewCellData) -> (Void))?
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
		setupCollectionView()
		colorSectionHeader()
    }
	
	func colorSectionHeader() {
		titleTextLabel.textColor = UIColor.sectionTitle
		titleDetailImageView.image = titleDetailImageView.image?.withRenderingMode(.alwaysTemplate)
		titleDetailImageView.tintColor = UIColor.sectionTitle
	}
	
	func setupCollectionView() {
		collectionView.register(nib: collectionCellNibName, forCellReuseIdentifier: collectionReuseIdentifier)
		collectionView.dataSource = self
		collectionView.delegate = self
	}
}

// MARK: - UICollectionView
extension NestedCollectionTableViewCell {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return min(collectionViewData.count, 10)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionReuseIdentifier, for: indexPath) as! BaseCollectionViewCell
		cell.setContent(data: collectionViewData[indexPath.row])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		didSelectCollectionViewCell?(collectionViewData[indexPath.row])
	}
}
