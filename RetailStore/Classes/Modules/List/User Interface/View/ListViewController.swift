//
//  ListViewController.swift
//  RetailStore
//
//  Created by Romdoni Agung Purbayanto on 05/02/18.
//  Copyright © 2018 Romdoni Agung Purbayanto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    var eventHandler : ListPresenter?
    
    var totalPrice: Int = 0
    var cartItems = [CartItem]()
    var screenType = ScreenType.List
    
    var dataArray = [Product]()
    var dataVariableArray: Variable<[SectionModel<NSNumber, Product>]> = Variable([])
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCells()
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.updateCartCount()
        self.eventHandler?.updateView(screenType: screenType)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    fileprivate func registerCells() {
        self.tableView.register(UINib(
            nibName: "ListTableViewCell",
            bundle: Bundle.main
        ), forCellReuseIdentifier: ListTableViewCell.identifier)
        
        self.tableView.register(UINib(
            nibName: "ListTotalTableViewCell",
            bundle: Bundle.main
        ), forCellReuseIdentifier: ListTotalTableViewCell.identifier)
    }
    
    func configureView() {
        // Title
        navigationItem.title = screenType.title()
        
        // Cart Button Configuration
        self.configureCart(in: self)
        
        // Table View Configuration
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<NSNumber, Product>>(configureCell: {(_, tableView: UITableView, indexPath: IndexPath, product: Product) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
                print("no cell found")
                return UITableViewCell()
            }

            cell.screenType = self.screenType
            cell.configureWithProduct(product: product)

            return cell
        })
        
        dataSource.canEditRowAtIndexPath = { (dataSource, indexPath) -> Bool in
            return self.screenType == .Cart
        }
        
        dataSource.titleForHeaderInSection = { dataSource, sectionIndex in
            return Category(rawValue: dataSource[sectionIndex].model.intValue)?.title()
        }
        
        dataVariableArray.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemSelected
            .map { indexPath in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { indexPath, model in
                // Navigate to Detail screen from here
                self.eventHandler?.showDetail(product: model)
            })
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemDeleted
            .map { indexPath in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { indexPath, model in
                self.deleteCartItem(withProduct: model)
            })
            .disposed(by: disposeBag)
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
    }
    
    func deleteCartItem(withProduct product: Product) {
        eventHandler?.deleteCartItem(withProductId: product.productId.int16Value)
        updateCartCount()
        eventHandler?.updateView(screenType: screenType)
    }
    
    
    func showProducts(sectioned data: [SectionModel<NSNumber, Product>]) {
        if screenType == ScreenType.Cart {
            totalPrice = calculateTotalPrice(sectioned: data)
            tableView.tableFooterView = totalCellView()
        }
        
        dataVariableArray.value = data
    }
    
    func totalCellView() -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: ListTotalTableViewCell.identifier) as? ListTotalTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(withPrice: self.totalPrice)
        
        return cell
    }
    
    func calculateTotalPrice(sectioned data: [SectionModel<NSNumber, Product>]) -> Int {
        var total = 0
        for section in data {
            for product in section.items {
                total += product.price.intValue
            }
        }
        
        return total
    }
    
    func updatedCartItems(_ cartItems: [CartItem]) {
        self.cartItems = cartItems
        updateCartCount()
    }
    
}


// MARK: - UITableView Delegate

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        if screenType == .Cart {
            return true
        }
        
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if screenType == .Cart {
            return .delete
        }
        
        return .none
    }
    
}


extension ListViewController: Cart {
    
    func cartIconTapped() {
        navigate(toCart: self)
    }
    
}



