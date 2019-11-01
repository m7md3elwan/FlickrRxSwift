//
//  SearchTerm.swift
//  MobiquityTask
//
//  Created by Elwan on 11/1/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import CoreData
import RxCoreData

struct SearchTerm {
    var text: String
    var accessDate: Date
}

extension SearchTerm: Equatable {
    static func == (lhs: SearchTerm, rhs: SearchTerm) -> Bool {
        return lhs.text == rhs.text
    }
}

extension SearchTerm : Persistable {
    var identity: String {
        return text
    }
    
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "SearchTerm"
    }
    
    static var primaryAttributeName: String {
        return "text"
    }
    
    init(entity: T) {
        text = entity.value(forKey: "text") as! String
        accessDate = entity.value(forKey: "accessDate") as! Date
    }
    
    func update(_ entity: T) {
        entity.setValue(text, forKey: "text")
        entity.setValue(accessDate, forKey: "accessDate")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
    
}
