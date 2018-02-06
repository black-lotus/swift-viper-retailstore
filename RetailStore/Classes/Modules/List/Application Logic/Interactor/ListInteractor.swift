//
//  ListInteractor.swift
//  RetailStore
//
//  Created by Romdoni Agung Purbayanto on 05/02/18.
//  Copyright © 2018 Romdoni Agung Purbayanto. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class ListInteractor {
    
    let dataManager : ListDataManager
    
    var products: Variable<[Product]> = Variable([])
    
    init(dataManager: ListDataManager) {
        self.dataManager = dataManager
    }
    
    func fetchProductsFromStore() -> Observable<[Product]> {
        self.products.value.removeAll()
        for prod in dataManager.productsArray {
            self.products.value.append(prod)
        }
        
        return Observable.create { observer in
            observer.onNext(self.products.value)
            return Disposables.create()
        }
    }
    
    func sectionedData(data: [Product]) -> [SectionModel<NSNumber, Product>] {
        
        var sectioned = [SectionModel<NSNumber, Product>]()
        for index in Category.Electronics.rawValue...Category.Furniture.rawValue {
            let filteredProducts = filterProducts(data: data, withCategoryId: index)
            let sectionModel = SectionModel(model: NSNumber(value: index), items: filteredProducts)
            sectioned.append(sectionModel)
        }
        
        return removeEmptySections(sectionArray: sectioned)
    }
    
    func removeEmptySections(sectionArray: [SectionModel<NSNumber, Product>]) -> [SectionModel<NSNumber, Product>]  {
        var filteredSections = [SectionModel<NSNumber, Product>]()
        for sectionModel in sectionArray {
            if sectionModel.items.count > 0 {
                filteredSections.append(sectionModel)
            }
        }
        return filteredSections
    }
    
    func filterProducts(data: [Product], withCategoryId categoryId: Int) -> [Product] {
        let returnValue = data.filter({
            return $0.categoryId.intValue == categoryId
        })
        return returnValue
    }
    
}
