//
//  AddressCell.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 14/10/23.
//

import UIKit

class AddressCell: UITableViewCell {
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    public static let cellId = "AddressCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
