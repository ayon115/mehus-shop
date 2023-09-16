//
//  CategoryController.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 2/9/23.
//


import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON

class CategoryController: UIViewController {
    
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    let products: [DisplayProduct] = [
        DisplayProduct(id: 1, name: "Football", description: "Standard football mid range. The first was that your selector was missing the name of its parameter. ", discountedPrice: 40.0, originalPrice: 60.0, addedCount: 0),
        DisplayProduct(id: 1, name: "Cricket Bat", description: "Cricket bat high quality. Your code has two problems.", discountedPrice: 60.0, originalPrice: 80.0, addedCount: 0),
        DisplayProduct(id: 1, name: "Hockey stick", description: "Hockey stick mid range", discountedPrice: 50.0, originalPrice: 60.0, addedCount: 0),
        DisplayProduct(id: 1, name: "Rugby Ball", description: "Rugby ball description. One was identified and answered, but the other wasn't. The first was that your selector was missing the name of its parameter. ", discountedPrice: 90.0, originalPrice: 110.0, addedCount: 0),
        DisplayProduct(id: 1, name: "Adidas Shoe", description: "Adidas shoe description", discountedPrice: 80.0, originalPrice: 90.0, addedCount: 0),
        DisplayProduct(id: 1, name: "Puma Jersey", description: "Puma Jersey description", discountedPrice: 90.0, originalPrice: 100.0, addedCount: 0)
    ]
    
    var categoryCollection: [JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Browse Products"
        
        self.mCollectionView.dataSource = self
        self.mCollectionView.delegate = self
        
        self.mCollectionView.setCollectionViewLayout(UICollectionViewFlowLayout.init(), animated: true)
        
        let productNib = UINib(nibName: CellIdentifier.productCell, bundle: nil)
        self.mCollectionView.register(productNib, forCellWithReuseIdentifier: CellIdentifier.productCell)
        
        let categoryHolderNib = UINib(nibName: CellIdentifier.categoryHolderCell, bundle: nil)
        self.mCollectionView.register(categoryHolderNib, forCellWithReuseIdentifier: CellIdentifier.categoryHolderCell)
        
        let sectionHeaderNib = UINib(nibName: CellIdentifier.collectionSectionHeaderView, bundle: nil)
        self.mCollectionView.register(sectionHeaderNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CellIdentifier.collectionSectionHeaderView)
        
        self.fetchProductCategories()
    }
}

// UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension CategoryController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.products.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            let categoryHolderCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.categoryHolderCell, for: indexPath) as! CategoryHolderCell
            categoryHolderCell.setCategoriesAndReload(cats: self.categoryCollection)
            return categoryHolderCell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.productCell, for: indexPath) as! ProductCell
            let product = self.products[row]
            cell.setProductInformation(product: product)
            return cell
        }
    }
}

extension CategoryController: UICollectionViewDelegate {
    
}

extension CategoryController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        if section == 0 {
            return CGSize(width: self.view.frame.width, height: 120.0)
        }
        return sizeForItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = mCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CellIdentifier.collectionSectionHeaderView, for: indexPath) as! CollectionSectionHeaderView
        if indexPath.section == 0 {
            header.headerTitleLabel.text = "Product Categories"
        } else {
            header.headerTitleLabel.text = "Popular Products"
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50.0)
    }
    
}

extension CategoryController {
    
    func sizeForItem () -> CGSize {
        let screenWidth = self.view.frame.width
        let spacingBetweenItems = 10.0
        let spacingAtEdges = 10.0
        let numberOfItemsInEachRow = 2
        
        let totalSpacing = (spacingAtEdges * 2) + (Double((numberOfItemsInEachRow - 1)) * spacingBetweenItems)
        let itemWidth = (screenWidth - totalSpacing) / 2
        
        return CGSize(width: itemWidth, height: 275.0)
    }
}

extension CategoryController {
    
    func fetchProductCategories () {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = RestClient.baseUrl + RestClient.categoryUrl
        AF.request(url).responseData { response in
            debugPrint(response)
            MBProgressHUD.hide(for: self.view, animated: true)
            
            switch (response.result) {
                case .success:
                    print("Validation Successful")
                if let responseData = response.value {
                    do {
                        let json = try JSON (data: responseData)
                       // print(json)
                        if let array = json.array {
                            self.categoryCollection = array
                            self.mCollectionView.reloadData()
                        }
                       // print("categoryCol = \(self.categoryCollection)")
                    } catch let error {
                        print(error)
                    }
                }
                
                case let .failure(error):
                    print(error)
            }
        }
    }
    
    
}
