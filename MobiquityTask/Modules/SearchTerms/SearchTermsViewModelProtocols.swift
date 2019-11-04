//
//  SearchTermsViewModelProtocols.swift
//  MobiquityTask
//
//  Created Elwan on 10/31/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SearchTermsViewModelInput {
    var searchTrigger: AnyObserver<String> { get } // Used to make a new Search
    var searchText: AnyObserver<String> { get } // Used to filter shown history
}

protocol SearchTermsViewModelOutput {
    var searchHistory: Driver<[String]> { get }
}

protocol SearchTermsViewModelType {
    var input: SearchTermsViewModelInput { get }
    var output: SearchTermsViewModelOutput { get }
}

extension SearchTermsViewModelType where Self: SearchTermsViewModelInput & SearchTermsViewModelOutput {
    var input: SearchTermsViewModelInput { return self }
    var output: SearchTermsViewModelOutput { return self }
}
