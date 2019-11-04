//
//  Photo.swift
//  MobiquityTask
//
//  Created by Elwan on 11/2/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation

struct Photo: Codable {
    var id: String
    var owner: String
    var farm: Int
    var secret: String
    var server: String
    var title: String
    
    var url: URL? {
        return URL(string: "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg")
    }
}
