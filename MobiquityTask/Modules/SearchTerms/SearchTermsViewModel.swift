//
//  SearchTermsViewModel.swift
//  MobiquityTask
//
//  Created Elwan on 10/31/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import RxSwift
import RxCocoa
import XCoordinator

class SearchTermsViewModel: SearchTermsViewModelType, SearchTermsViewModelInput, SearchTermsViewModelOutput {
    
    // MARK:- Inputs
    let searchTrigger: AnyObserver<String>
    var searchText: AnyObserver<String>
    
    // MARK:- Outputs
    var searchHistory: Driver<[String]>
    
    // MARK:- Properties
    var router: UnownedRouter<AppStartUpRoute>
    var searchHistoryService: SearchHistoryServicing
    
    // MARK:- Initialization
    init(service: SearchHistoryServicing, router: UnownedRouter<AppStartUpRoute>) {
        self.searchHistoryService = service
        self.router = router
        
        let _searchText = PublishSubject<String>()
        self.searchText = _searchText.asObserver()
        
        searchHistory = _searchText.flatMapLatest({(text) -> Observable<[String]> in
            return service.fetchSearchHistory(containing: text)
        }).asDriver(onErrorJustReturn: [])
        
        let _searchTrigger = PublishSubject<String>().asObserver()
        self.searchTrigger = _searchTrigger.asObserver()
        
        _ = _searchTrigger
            .filter{ !$0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty }
            .subscribe(onNext: { (text) in
            _ = service.addSearchTerm(text: text)
        })
    }
    
}
