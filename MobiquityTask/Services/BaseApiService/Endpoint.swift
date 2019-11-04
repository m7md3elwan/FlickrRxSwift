//
//  Endpoint.swift
//  MobiquityTask
//
//  Created by Elwan on 11/2/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var base: String { get }
}

extension Endpoint {
    var base: String {
        return AppConstants.defaultBaseUrl
    }
}
