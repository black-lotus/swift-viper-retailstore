//
//  DetailViewController.swift
//  RetailStore
//
//  Created by romdoni agung purbayanto on 06/02/18.
//  Copyright © 2018 Romdoni Agung Purbayanto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    var eventHandler : DetailPresenter?
    
    var product: Product?
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var addToCartButton : UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.updateCartCount()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func configureView() {
        navigationItem.title = "Product Detail"
        
        // Cart Button Configuration
        self.configureCart(in: self)
        
        //Binding data
        nameLabel.text = product?.name
        priceLabel.text = "Rs. " + (product?.price.stringValue)!
        if let imageName = product?.imageName {
            imageView.image = UIImage(named: imageName)
        }
        
    }
    
    
    //MARK:
    //MARK: Actions
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        if let productId = product?.productId {
            eventHandler?.add(toCart: productId)
            addToCartButton.isUserInteractionEnabled = false
            addToCartButton.setTitle("Added!", for: .normal)
        }
    }

}


extension DetailViewController: Cart {
    
    func cartIconTapped() {
        navigate(toCart: self)
    }
    
    
}






