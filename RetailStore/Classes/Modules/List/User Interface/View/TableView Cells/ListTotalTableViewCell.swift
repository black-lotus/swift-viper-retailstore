//
//  ListTotalTableViewCell.swift
//  RetailStore
//
//  Created by romdoni agung purbayanto on 06/02/18.
//  Copyright © 2018 Romdoni Agung Purbayanto. All rights reserved.
//

import UIKit

class ListTotalTableViewCell: UITableViewCell {

    public static let identifier: String = "ListTotalTableViewCell"
    
    @IBOutlet private var totalPriceLabel: UILabel!
    
    func configure(withPrice price: Int) {
        totalPriceLabel.text = "Rs. \(price)"
    }
    
}
