//
//  ListTableViewCell.swift
//  RetailStore
//
//  Created by Romdoni Agung Purbayanto on 05/02/18.
//  Copyright © 2018 Romdoni Agung Purbayanto. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    public static let identifier: String = "ListTableViewCell"
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet internal var productImageView: UIImageView!
    
    var screenType = ScreenType.List
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithProduct(product: Product) {
        guard let productName = product.name else {
            return
        }
        
        nameLabel.text = productName
        productImageView.image = UIImage(named: product.imageName)
        
        if screenType == .Cart {
            priceLabel.isHidden = false
            if let price = product.price {
                priceLabel.text = "Rs. \(price)"
            }
        }
    }
    
}
