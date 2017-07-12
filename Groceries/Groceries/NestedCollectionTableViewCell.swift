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
	let collectionCellNibName = "BaseCollectionViewCell"
	let collectionReuseIdentifier = "BaseCollectionCell"
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
		collectionView.register(nib: collectionCellNibName, forCellReuseIdentifier: collectionReuseIdentifier)
		collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: - UICollectionView
extension NestedCollectionTableViewCell {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionReuseIdentifier, for: indexPath)
		return cell
	}
}
