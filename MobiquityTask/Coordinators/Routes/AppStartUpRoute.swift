//
//  AppStartUpRoute.swift
//  MobiquityTask
//
//  Created by Elwan on 10/31/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import XCoordinator

enum AppStartUpRoute: Route {
    case gallery(searchText: String)
    case search
}
