//
//  SearchTermsViewModelViewController.swift
//  MobiquityTask
//
//  Created Elwan on 10/31/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchTermsViewController: BaseViewController, BindableType {

    // MARK:- Constants
    struct Constants {
        static let cellIdentifier = "SearchTermTableViewCell"
    }

    // MARK:- Properties
    private let disposeBag = DisposeBag()
    var viewModel: SearchTermsViewModelType!

    // MARK:- Outlets
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var historyTableView: UITableView!
    
    // MARK:- UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerCells()
    }
    
    // MARK:- Methods
    func bindViewModel() {        
        searchTextField.rx.controlEvent([.editingDidEnd]).map{ self.searchTextField.text ?? "" }.bind(to: viewModel.input.searchTrigger).disposed(by: disposeBag)
        searchTextField.rx.text.orEmpty.map{ $0 }.asObservable().bind(to: viewModel.input.searchText ).disposed(by: disposeBag)
        
        viewModel.output.searchHistory.drive(historyTableView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: SearchTermTableViewCell.self)) { tableview, viewModel, cell in
            cell.configure(text: viewModel)
        }.disposed(by: disposeBag)
    }
    
    fileprivate func setupTableView() {
        historyTableView.estimatedRowHeight = 100
        historyTableView.tableFooterView = UIView()
    }
    
    fileprivate func registerCells() {
        let searchTermCell = UINib(nibName: Constants.cellIdentifier, bundle:nil)
        historyTableView.register(searchTermCell, forCellReuseIdentifier: Constants.cellIdentifier)
    }
}
