//
//  BaseViewController.swift
//  MobiquityTask
//
//  Created by Elwan on 10/31/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import UIKit
import SwiftMessages

protocol BaseViewing: class {
    func showLoader()
    func hideLoader()
    func showSuccessMessage(text: String?)
    func showErrorMessage(text: String?)
}

class BaseViewController: UIViewController, BaseViewing {

    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.style = .large
        self.view.addSubview(activity)
        activity.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        return activity
    }()
    
    func showErrorMessage(text: String?) {
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(Theme.error, iconStyle: IconStyle.none)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.configureContent(title: nil, body: text, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        var config = SwiftMessages.Config.init()
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal.rawValue)
        SwiftMessages.show(config: config, view: view)
    }
    
    func showSuccessMessage(text: String?) {
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(Theme.success, iconStyle: IconStyle.none)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.configureContent(title: nil, body: text, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        SwiftMessages.show(view: view)
    }
    
    func showLoader() {
        view.bringSubviewToFront(activity)
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func hideLoader() {
        activity.isHidden = true
        activity.stopAnimating()
    }
}
