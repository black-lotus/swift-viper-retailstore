//
//  DetailManager.swift
//  RetailStore
//
//  Created by romdoni agung purbayanto on 06/02/18.
//  Copyright © 2018 Romdoni Agung Purbayanto. All rights reserved.
//

import Foundation

class DetailManager {

    var dataStore = CoreDataStore.sharedInstance
    
    func saveMOC() {
        dataStore.save()
    }
    
    func newCartItem() -> CartItem {
        return dataStore.newCartItem()
    }
    
    func deleteObject(cartItem: CartItem) {
        dataStore.deleteObject(cartItem: cartItem)
    }
    
    func cartItemsFromStore(_ completion: (([CartItem]) -> Void)!) {
        dataStore.fetchEntriesWithPredicate({ entries in
            completion(entries)
        })
    }
    
    func save(cartItem: CartItem) {
        deleteSimilarCartItems(cartItem: cartItem)
        saveMOC()
    }
    
    func deleteSimilarCartItems(cartItem: CartItem) {
        dataStore.checkForSimilarCartItemAndDelete(cartItemToCheck: cartItem)
    }
    
    func delete(cartItem: CartItem) {
        dataStore.deleteObject(cartItem: cartItem)
    }
    
}
