//
//  GalleryViewModelViewController.swift
//  MobiquityTask
//
//  Created Elwan on 11/1/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class GalleryViewController: BaseViewController, BindableType {

    // MARK:- Constants
    struct Constants {
        static let cellIdentifier = "GalleryCollectionViewCell"
    }

    // MARK:- Properties
    private let disposeBag = DisposeBag()
    var viewModel: GalleryViewModelType!

    // MARK:- Outlets
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK:- UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        registerCells()
    }
    
    // MARK:- Methods
    override func hideLoader() {
        super.hideLoader()
        collectionView.finishInfiniteScroll()
    }
    
    func bindViewModel() {
        searchButton.rx.tap.bind(to: viewModel.input.newSearchTrigger).disposed(by: disposeBag)
        viewModel.output.searchText.bind(to: searchButton.rx.title(for: [])).disposed(by: disposeBag)
        
        rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
            .take(1).map{ _ in }.bind(to: viewModel.output.resetLoadTrigger)
        
        viewModel.output.data.drive(collectionView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: GalleryCollectionViewCell.self)) { item, data, cell in
            cell.confiure(url: data.url)
        }.disposed(by: disposeBag)
        
        collectionView.addInfiniteScroll { (collectionView) in
            self.viewModel.output.nextPageLoadTrigger.on(.next(()))
        }
        
        viewModel.output.errors.asObservable().subscribe(onNext: { (error) in
            self.showErrorMessage(text: error.localizedDescription)
            self.hideLoader()
        }).disposed(by: disposeBag)
        
        viewModel.output.loading.asObservable().observeOn(MainScheduler.instance).subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoader()
            } else {
                self.hideLoader()
            }
        }).disposed(by: disposeBag)
    }
    
    fileprivate func configureCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        let width = collectionView.bounds.width/2 - 35
        let height = collectionView.bounds.width * 0.6
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
    
    fileprivate func registerCells() {
        let galleryCell = UINib(nibName: Constants.cellIdentifier, bundle:nil)
        collectionView.register(galleryCell, forCellWithReuseIdentifier: Constants.cellIdentifier)
    }
}
