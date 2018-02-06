//
//  DetailWireframe.swift
//  RetailStore
//
//  Created by romdoni agung purbayanto on 06/02/18.
//  Copyright © 2018 Romdoni Agung Purbayanto. All rights reserved.
//

import Foundation
import UIKit

class DetailWireframe {
    
    public static let identifier: String = "DetailViewController"
    
    var detailPresenter : DetailPresenter?
    var presentedViewController : DetailViewController?
    
    func presentDetailInterface(fromViewController viewController: UIViewController, withProduct product: Product) {
        let newViewController = detailViewControllerFromStoryboard()
        newViewController.eventHandler = detailPresenter
        newViewController.product = product
        detailPresenter?.userInterface = newViewController
        viewController.navigationController?.pushViewController(newViewController, animated: true)
        
        presentedViewController = newViewController
    }
    
    func displayAlert(title: String? = nil, message: String? = nil) {
        var titleString = "Error"
        var messageString = "Product was already added to Cart"
        if title != nil {
            titleString = title!
        }
        if message != nil {
            messageString = message!
        }
        
        let alertController = UIAlertController(title: titleString, message: messageString, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        presentedViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func detailViewControllerFromStoryboard() -> DetailViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: DetailWireframe.identifier) as! DetailViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
    
}
