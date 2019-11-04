//
//  BaseAPIService.swift
//  MobiquityTask
//
//  Created by Elwan on 11/2/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import Foundation
import Alamofire

class BaseAPIService: NSObject {

    public enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    fileprivate func getFullUrl(for endPoint: Endpoint) -> String {
        return "\(endPoint.base)\(endPoint.path)"
    }

    func execute<Model:Codable>(endPoint: Endpoint, method:BaseAPIService.HTTPMethod = .get, parameters:[String:Any] = [:], completionHandler: @escaping (Swift.Result<Model, Error>) -> Void ) {
        
        var generalParameters = [String:Any]()
        generalParameters.merge(with: parameters)
        
        let endpointUrl = getFullUrl(for: endPoint)
        
        Alamofire.request(endpointUrl, method: Alamofire.HTTPMethod.init(rawValue: method.rawValue)!, parameters: generalParameters, headers: nil).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let object = try JSONDecoder().decode(Model.self, from: data)
                    completionHandler(Swift.Result.success(object))
                }
                catch {
                    completionHandler(Swift.Result.failure(BaseAPIServiceError.parsingError))
                }
            case .failure(let error):
                completionHandler(Swift.Result.failure(BaseAPIServiceError.serverError(message: error.localizedDescription, code: error.code)))
            }
        }
    }
}
