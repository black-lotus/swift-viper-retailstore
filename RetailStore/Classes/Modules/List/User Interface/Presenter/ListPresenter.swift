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
    
    func updateView(screenType: ScreenType) {
        //Cart Items
        listInteractor?.fetchCartItemsFromStore()
            .asObservable().subscribe( {onNext in
                guard let cartItems = self.listInteractor?.cartItems else {
                    return
                }
                self.updateUserInterface(with: cartItems.value)
                if let filteredProducts = self.listInteractor?.cartItemProducts(cartItems: cartItems.value) {
                    if let sectioned = self.listInteractor?.sectionedData(data: filteredProducts) {
                        if (screenType == .Cart) {
                            self.updateUserInterface(withCartSectionedProducts: sectioned)
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
        
        //Products
        listInteractor?.fetchProductsFromStore()
            .asObservable().subscribe( {onNext in
                guard let products = self.listInteractor?.products else {
                    return
                }
                if let sectioned = self.listInteractor?.sectionedData(data: products.value) {
                    if screenType == .List {
                        self.updateUserInterface(withSectionedProducts: sectioned)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    func updateUserInterface(with cartItems: [CartItem]) {
        userInterface?.updatedCartItems(cartItems)
    }
    
    func updateUserInterface(withCartSectionedProducts sectionedProducts: [SectionModel<NSNumber, Product>]) {
        userInterface?.showProducts(sectioned: sectionedProducts)
    }
    
    func updateUserInterface(withSectionedProducts sectionedProducts: [SectionModel<NSNumber, Product>]) {
        userInterface?.showProducts(sectioned: sectionedProducts)
    }
    
    func showDetail(product: Product) {
        listWireframe?.navigateToDetail(withProduct: product)
    }
    
}
