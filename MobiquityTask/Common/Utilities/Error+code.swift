//
//  Error+code.swift
//  MobiquityTask
//
//  Created by Elwan on 11/1/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
    var userInfo: [String: Any] { return (self as NSError).userInfo }
}
