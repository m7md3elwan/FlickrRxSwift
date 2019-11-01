//
//  SearchTextCoreDataService.swift
//  MobiquityTask
//
//  Created by Elwan on 11/1/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import RxSwift
import CoreData
import RxCoreData

final class SearchTextCoreDataService: SearchHistoryServicing {
    
    var managedObjectContext: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
         managedObjectContext = context
    }
    
    func fetchSearchHistory(containing text: String) -> Observable<[String]> {
        var predicate: NSPredicate? = nil
        if !text.isEmpty {
            predicate = NSPredicate(format: "text CONTAINS[cd] %@", text)
        }
        return managedObjectContext.rx.entities(SearchTerm.self, predicate: predicate, sortDescriptors: [NSSortDescriptor(key: "accessDate", ascending: false)]).map {
            $0.map{ ($0.text) }
        }
    }
    
    func addSearchTerm(text: String) -> Observable<Void> {
        let searchTerm = SearchTerm(text: text, accessDate: Date())
        try? managedObjectContext.rx.update(searchTerm)
        return Observable.just(Void())
    }
    
}
