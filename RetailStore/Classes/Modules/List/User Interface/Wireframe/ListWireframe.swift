//
//  ListWireframe.swift
//  RetailStore
//
//  Created by Romdoni Agung Purbayanto on 05/02/18.
//  Copyright © 2018 Romdoni Agung Purbayanto. All rights reserved.
//

import Foundation
import UIKit

class ListWireframe : NSObject {
    
    public static let identifier: String = "ListViewController"
    
    var listPresenter : ListPresenter?
    var rootWireframe : RootWireframe?
    var listViewController : ListViewController?
    
    func configuredListViewController() -> ListViewController {
        let viewController = listViewControllerFromStoryboard()
        viewController.eventHandler = listPresenter
        listViewController = viewController
        listPresenter?.userInterface = viewController
        return viewController
    }
    
    func presentListInterfaceFromWindow(_ window: UIWindow) {
        let viewController = configuredListViewController()
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func listViewControllerFromStoryboard() -> ListViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ListWireframe.identifier) as! ListViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
    
    func navigateToDetail(withProduct product: Product) {
        let detailWireframe = DetailWireframe()
        let detailManager = DetailManager()
        let detailInteractor = DetailInteractor(detailManager: detailManager)
        let detailPresenter = DetailPresenter()
        detailPresenter.detailInteractor = detailInteractor
        detailPresenter.detailWireframe = detailWireframe
        detailWireframe.detailPresenter = detailPresenter
        detailWireframe.presentDetailInterface(fromViewController: listViewController!, withProduct: product)
    }
    
    func navigate(toCart fromViewController: UIViewController) {
        let cartViewController = configuredListViewController()
        cartViewController.screenType = .Cart
        fromViewController.navigationController?.pushViewController(cartViewController, animated: true)
    }
    
    
}
