//
//  GalleryImagesService.swift
//  MobiquityTask
//
//  Created by Elwan on 11/3/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import RxSwift

final class GalleryImagesAPIService: BaseAPIService {
    enum GalleryImagesEndPoint: Endpoint {
        case search(text: String, page: Int)
        
        var path: String {
            switch self {
            case .search(_):
                return ""
            }
        }
        
        var parameters: [String : Any] {
            switch self {
            case .search(let text, let page):
                return ["api_key": "11c40ef31e4961acf4f98c8ff4e945d7",
                        "text": text,
                        "page": page,
                        "per_page": 10,
                        "format": "json",
                        "method": "flickr.photos.search",
                        "nojsoncallback": 1]
                
            }
        }
    }
}

extension GalleryImagesAPIService: GalleryImagesServicing {
    func fetchPhotos(page: Int, text: String) -> Observable<PhotosWrapper> {
        return Observable.create { observer in
            let endPoint = GalleryImagesEndPoint.search(text: text, page: page)
            self.execute(endPoint: endPoint, parameters: endPoint.parameters) { (result: Result<PhotosWrapper, Error>) in
                switch result {
                case .success(let vehiclesWrapper):
                    observer.on(.next(vehiclesWrapper))
                    observer.on(.completed)
                case .failure(let error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
