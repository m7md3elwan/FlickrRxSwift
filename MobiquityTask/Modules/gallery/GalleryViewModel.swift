//
//  GalleryViewModel.swift
//  MobiquityTask
//
//  Created Elwan on 11/1/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import RxSwift
import RxCocoa
import XCoordinator

class GalleryViewModel: GalleryViewModelType, GalleryViewModelInput, GalleryViewModelOutput {
    
    // MARK:- Inputs
    var newSearchTrigger: AnyObserver<Void>
    
    var resetLoadTrigger: AnyObserver<Void>
    var nextPageLoadTrigger: AnyObserver<Void>
    
    // MARK:- Outputs
    var searchText: Observable<String>
    var data: Driver<[Photo]>
    let loading: Driver<Bool>
    let errors: Driver<Error>
    
    // MARK:- External Output
    let currentSearchText = BehaviorRelay<String>(value: "Netherlands")

    // MARK:- Properties
    var router: UnownedRouter<AppStartUpRoute>
    private let galleryService: GalleryImagesServicing
    
    let currentPage = BehaviorRelay<Int>(value: 0)
    let loadedData = BehaviorRelay<[Photo]>(value: [])

    // MARK:- Initialization
    init(router: UnownedRouter<AppStartUpRoute>, galleryService: GalleryImagesServicing) {
        self.router = router
        self.galleryService = galleryService
        
        searchText = currentSearchText.asObservable()
        
        let activityIndicator = ActivityIndicator()
        loading = activityIndicator.asDriver()
        
        let errorTracker = ErrorTracker()
        errors = errorTracker.asDriver()
        
        /// Used to start search when view load or pull to refresh
        let _resetLoadTrigger = PublishSubject<Void>()
        resetLoadTrigger = _resetLoadTrigger.asObserver()

        /// Used to fetch next data page
        let _nextPageLoadTrigger = PublishSubject<Void>()
        nextPageLoadTrigger = _nextPageLoadTrigger.asObserver()
        
        /// Used to open change search term screen
        let _newSearchTrigger = PublishSubject<Void>()
        newSearchTrigger = _newSearchTrigger.asObserver()
        
        data = loadedData.asDriver()

        
        /// fetching data
        let loadNext = _nextPageLoadTrigger.flatMap { _ -> Observable<[Photo]> in
            self.currentPage.accept(self.currentPage.value + 1)
            return galleryService.fetchPhotos(page: self.currentPage.value, text: self.currentSearchText.value)
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .map{ $0.photos }
        }
        
        _ = loadNext.subscribe(onNext: { (photos) in
            self.loadedData.accept(self.loadedData.value + photos)
        })
        
        
        _ = _newSearchTrigger.subscribe(onNext: { _ in
            router.trigger(.search(searchObserver: self.currentSearchText))
        })

        _ = Observable.combineLatest(_resetLoadTrigger.asObservable(), currentSearchText.asObservable()).subscribe(onNext: { _ in
            self.currentPage.accept(0)
            self.loadedData.accept([])
            _nextPageLoadTrigger.onNext(())
        })
    }
}
