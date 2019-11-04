//
//  GalleryImagesServicing.swift
//  MobiquityTask
//
//  Created by Elwan on 11/2/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import RxSwift

protocol GalleryImagesServicing {
    func fetchPhotos(page: Int, text: String) -> Observable<PhotosWrapper>
}
