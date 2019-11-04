//
//  PhotosWrapper.swift
//  MobiquityTask
//
//  Created by Elwan on 11/2/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

class PhotosWrapper: Codable {
    let photos: [Photo]
    let page: Int
    let pages: Int
    
    enum CodingKeys: String, CodingKey {
        case photos = "photo"
        case page = "page"
        case pages = "pages"
    }
    
    enum ParenrCodingKeys: String, CodingKey {
        case photos = "photos"
    }
    
    required init(from decoder: Decoder) throws {
        let parentContainer = try decoder.container(keyedBy: ParenrCodingKeys.self)
        
        let map = try parentContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .photos)
        self.photos =  try map.decode(.photos) //map.decodeSafelyArray(of: Photo.self, forKey: .photos) // Discard malformed Photos
        self.page = try map.decode(.page)
        self.pages = try map.decode(.pages)
    }

}
