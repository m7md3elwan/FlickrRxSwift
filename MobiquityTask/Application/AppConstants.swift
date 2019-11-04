//
//  AppConstants.swift
//  MobiquityTask
//
//  Created by Elwan on 11/3/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

class AppConstants: NSObject {
    #if DEBUG
    static let defaultBaseUrl = "https://api.flickr.com/services/rest/"
    #else
    static let defaultBaseUrl = "https://api.flickr.com/services/rest/"
    #endif
}
