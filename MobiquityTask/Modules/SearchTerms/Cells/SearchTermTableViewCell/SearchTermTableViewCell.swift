//
//  SearchTermTableViewCell.swift
//  MobiquityTask
//
//  Created by Elwan on 11/1/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import UIKit

class SearchTermTableViewCell: UITableViewCell {
    
    @IBOutlet var searchTextLabel: UILabel!
    
    func configure(text: String) {
        searchTextLabel.text = text
    }
}
