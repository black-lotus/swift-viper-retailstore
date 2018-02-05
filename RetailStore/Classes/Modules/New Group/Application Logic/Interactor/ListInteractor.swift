//
//  ListInteractor.swift
//  RetailStore
//
//  Created by Romdoni Agung Purbayanto on 05/02/18.
//  Copyright © 2018 Romdoni Agung Purbayanto. All rights reserved.
//

import Foundation
import RxSwift

class ListInteractor {
    
    let dataManager : ListDataManager
    
    var products: Variable<[Product]> = Variable([])
    
    init(dataManager: ListDataManager) {
        self.dataManager = dataManager
    }
    
    func fetchProductsFromStore() {
        self.products.value.removeAll()
        for prod in dataManager.productsArray {
            self.products.value.append(prod)
        }
    }
    
}
