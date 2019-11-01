//
//  AppStartUpCoordinator.swift
//  MobiquityTask
//
//  Created by Elwan on 10/31/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import XCoordinator

class AppStartUpCoordinator: NavigationCoordinator<AppStartUpRoute> {
    
    init() {
        super.init()
        rootViewController.setNavigationBarHidden(true, animated: false)
    }
    
    override func prepareTransition(for route: AppStartUpRoute) -> NavigationTransition {
        switch route {
        case .search:
            let viewController: SearchTermsViewController = Storyboards.Main.instantiate()!
            let service = SearchTextCoreDataService(context: CoreDataManager.shared.managedContext)
            viewController.bind(to: SearchTermsViewModel(service: service, router: self.unownedRouter))
            return .present(viewController)
        default:
            let viewController = UIViewController()
            return .presentFullScreen(viewController)
        }
    }
}
