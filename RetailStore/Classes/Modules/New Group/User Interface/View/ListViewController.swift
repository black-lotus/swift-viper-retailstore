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
    
    var dataArray: Variable<[SectionModel<NSNumber, Product>]> = Variable([])
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCells()
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.eventHandler?.updateView()
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
    }
    
    func configureView() {
        //Title
        navigationItem.title = "Products"
        
        //Table View Configuration
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<NSNumber, Product>>(configureCell: {(_, tableView: UITableView, indexPath: IndexPath, product: Product) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
                print("no cell found")
                return UITableViewCell()
            }

            cell.configureWithProduct(product: product)

            return cell
        })
        
        dataSource.titleForHeaderInSection = { dataSource, sectionIndex in
            return Category(rawValue: dataSource[sectionIndex].model.intValue)?.title()
        }
        
        dataArray.asObservable()
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //MARK:
    //MARK: Other Methods
    func showProducts(sectioned data: [SectionModel<NSNumber, Product>]) {
        dataArray.value = data
    }
    
}

