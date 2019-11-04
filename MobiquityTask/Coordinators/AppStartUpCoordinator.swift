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
        case .search(let searchObserver):
            let viewController: SearchTermsViewController = Storyboards.Main.instantiate()!
            let service = SearchTextCoreDataService(context: CoreDataManager.shared.managedContext)
            viewController.bind(to: SearchTermsViewModel(service: service, router: self.unownedRouter, searchObserver: searchObserver))
            return .present(viewController)
        case .gallery:
            let viewController: GalleryViewController = Storyboards.Main.instantiate()!
            viewController.bind(to: GalleryViewModel(router: self.unownedRouter, galleryService: GalleryImagesAPIService()))
            return .push(viewController, animation: .none)
        case .endSearch:
            return .dismissToRoot()
        }
    }
}
