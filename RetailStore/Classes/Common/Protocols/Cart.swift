//
//  Cart.swift
//  RetailStore
//
//  Created by romdoni agung purbayanto on 06/02/18.
//  Copyright © 2018 Romdoni Agung Purbayanto. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

@objc protocol Cart : class {
    @objc optional func navigate(toCart fromViewController: UIViewController)
    func cartIconTapped()
}

extension Cart where Self: UIViewController {
    
    func updateCartCount() {
        //Update Cart Count on Cart Icon in the Navigation bar here
        let dataStore = CoreDataStore.sharedInstance
        dataStore.fetchCartItems({ cartItems in
            if let rightBarButtonItem = self.navigationItem.rightBarButtonItem, let cartButton = rightBarButtonItem.customView as? UIButton {
                if cartItems.count > 0 {
                    //cartButton.isHidden = false
                    cartButton.setTitle(" \(cartItems.count) ", for: .normal)
                }
                else {
                    cartButton.setTitle("", for: .normal)
                    //cartButton.isHidden = true
                }
            }
        })
    }
    
    func configureCart(in viewController: UIViewController) {
        //Cart Button Configuration
        var cartButton: UIBarButtonItem!
        let btn = UIButton(type: .custom)
        btn.contentMode = UIViewContentMode.scaleAspectFit
        btn.setBackgroundImage(UIImage(named: "cart"), for: .normal)
        //btn.setImage(UIImage(named: "cart"), for: .normal)
        
        let spacing: CGFloat = 10 // the amount of spacing to appear between image and title
        btn.imageEdgeInsets = UIEdgeInsetsMake(spacing, 0, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, spacing*3, 0);
        
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.addTarget(self, action: #selector(Self.cartIconTapped), for: .touchUpInside)
        btn.setTitle(" 0 ", for: .normal)
        btn.titleLabel?.backgroundColor = UIColor.red
        btn.titleLabel?.layer.masksToBounds = true
        btn.titleLabel?.layer.cornerRadius = (btn.frame.size.width-spacing)/2
        btn.titleLabel?.layer.borderWidth = 1
        btn.titleLabel?.layer.borderColor = UIColor.white.cgColor
        
        cartButton = UIBarButtonItem(customView: btn)
        viewController.navigationItem.setRightBarButton(cartButton, animated: true)
        
    }
    
    
    func navigate(toCart fromViewController: UIViewController) {
        let listWireFrame = AppDependencies.configureListViewDependencies()
        listWireFrame.navigate(toCart: fromViewController)
    }
    
}
