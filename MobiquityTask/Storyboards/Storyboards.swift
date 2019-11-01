//
//  Storyboards.swift
//  MobiquityTask
//
//  Created by Elwan on 10/31/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import UIKit

public enum Storyboards: String {
    case Main
    
    public func instantiate<ViewController: UIViewController>() -> ViewController? {
        guard let viewController = UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController else {
            return nil
        }
        return viewController
    }
}
