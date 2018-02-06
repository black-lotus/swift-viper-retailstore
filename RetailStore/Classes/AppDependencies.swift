//
//  AppDependencies.swift
//  RetailStore
//
//  Created by Romdoni Agung Purbayanto on 05/02/18.
//  Copyright © 2018 Romdoni Agung Purbayanto. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        let listWireframe = AppDependencies.configureListViewDependencies()
        listWireframe.presentListInterfaceFromWindow(window)
    }
    
    class func configureListViewDependencies() -> ListWireframe {
        let listWireframe = ListWireframe()
        let coreDataStore = CoreDataStore.sharedInstance
        let rootWireframe = RootWireframe()
        
        let listPresenter = ListPresenter()
        let listDataManager = ListDataManager()
        let listInteractor = ListInteractor(dataManager: listDataManager)
        
        listPresenter.listInteractor = listInteractor
        listPresenter.listWireframe = listWireframe
        
        listWireframe.listPresenter = listPresenter
        listWireframe.rootWireframe = rootWireframe
        
        listDataManager.coreDataStore = coreDataStore
        
        return listWireframe
    }
    
    deinit {
        print("AppDependencies Disposed")
    }
}
