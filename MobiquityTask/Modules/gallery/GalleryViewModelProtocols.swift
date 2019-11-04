//
//  GalleryViewModelProtocols.swift
//  MobiquityTask
//
//  Created Elwan on 11/1/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol GalleryViewModelInput {
    var newSearchTrigger: AnyObserver<Void> { get } // Used to make a new Search
}

protocol GalleryViewModelOutput {
    var searchText: Observable<String> { get }
    var data: Driver<[Photo]> { get }
    var loading: Driver<Bool> { get }
    var errors: Driver<Error> { get }
    var resetLoadTrigger: AnyObserver<Void> { get }
    var nextPageLoadTrigger: AnyObserver<Void> { get }
}

protocol GalleryViewModelType {
    var input: GalleryViewModelInput { get }
    var output: GalleryViewModelOutput { get }
}

extension GalleryViewModelType where Self: GalleryViewModelInput & GalleryViewModelOutput {
    var input: GalleryViewModelInput { return self }
    var output: GalleryViewModelOutput { return self }
}
