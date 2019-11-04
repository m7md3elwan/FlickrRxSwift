//
//  GalleryCollectionViewCell.swift
//  MobiquityTask
//
//  Created by Elwan on 11/1/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import UIKit
import Kingfisher

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var photoImageView: UIImageView!
    
    func confiure(url: URL?) {
        photoImageView.kf.setImage(with: url)
    }
}
