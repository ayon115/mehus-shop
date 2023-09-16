//
//  CategoryHolderCell.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 16/9/23.
//

import UIKit

class CategoryHolderCell: UICollectionViewCell {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    let categories : [String] = [
        "Electronics", "Fashion", "Accessories", "Sports", "Kids Items"
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.delegate = self
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        self.categoryCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        
        let categoryCellNib = UINib(nibName: CellIdentifier.categoryCell, bundle: nil)
        self.categoryCollectionView.register(categoryCellNib, forCellWithReuseIdentifier: CellIdentifier.categoryCell)
    }
}

extension CategoryHolderCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.categoryCell, for: indexPath) as! CategoryCell
        cell.nameLabel.text = categories[indexPath.row]
        cell.nameLabel.applyCorner(cornerRadius: 10.0, borderWidth: 0.0, borderColor: .clear)
        return cell
    }
    
}

extension CategoryHolderCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130.0, height: 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
    }
}
