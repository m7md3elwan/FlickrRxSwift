//
//  AppDelegate.swift
//  MobiquityTask
//
//  Created by Elwan on 10/31/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private lazy var mainWindow = UIWindow()
    private let router = AppStartUpCoordinator().strongRouter
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        IQKeyboardManager.shared.enable = true

        router.setRoot(for: mainWindow)
        router.trigger(.gallery)

        return true
    }

}

