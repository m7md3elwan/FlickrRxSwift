//
//  SearchHistoryServicing.swift
//  MobiquityTask
//
//  Created by Elwan on 11/1/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchHistoryServicing {
    func fetchSearchHistory(containing text: String) -> Observable<[String]>
    func addSearchTerm(text: String) -> Observable<Void>
}
