//
//  ListPresenter.swift
//  RetailStore
//
//  Created by Romdoni Agung Purbayanto on 05/02/18.
//  Copyright © 2018 Romdoni Agung Purbayanto. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources

class ListPresenter {
    
    var listWireframe : ListWireframe?
    var listInteractor : ListInteractor?
    var userInterface : ListViewController?
    let disposeBag = DisposeBag()
    
    func updateView() {
        //Products
        listInteractor?.fetchProductsFromStore()
            .asObservable().subscribe( {onNext in
                guard let products = self.listInteractor?.products else {
                    return
                }
                if let sectioned = self.listInteractor?.sectionedData(data: products.value) {
                    self.updateUserInterface(withSectionedProducts: sectioned)
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    func updateUserInterface(withSectionedProducts sectionedProducts: [SectionModel<NSNumber, Product>]) {
        userInterface?.showProducts(sectioned: sectionedProducts)
    }
    
    func showDetail(product: Product) {
        listWireframe?.navigateToDetail(withProduct: product)
    }
    
}
