//
//  ProductCell.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 12/9/23.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setProductInformation (product: DisplayProduct) {
        self.productImageView.image = UIImage(systemName: "football")
        self.productNameLabel.text = product.name
        self.productDescriptionLabel.text = product.description
        
        
        let strokeEffect: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.strikethroughColor: UIColor.red,
        ]

        let originalPrice = NSAttributedString(string: "Tk " + String(product.originalPrice), attributes: strokeEffect)
        let finalAttributedString = NSMutableAttributedString()
        finalAttributedString.append(originalPrice)
        finalAttributedString.append(NSAttributedString(string: " Tk "))
        finalAttributedString.append(NSAttributedString(string: String(product.discountedPrice)))
        self.productPriceLabel.attributedText = finalAttributedString
    }
}
