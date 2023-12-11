//
//  APILoginRouter.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 6/12/23.
//

import Foundation
import Alamofire
import UIKit

enum LoginAPI: APIConfiguration {
    
    case login(parameters: Parameters)
    case validateToken
 
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .validateToken:
            return .get
        }
    }

    var path: String {
        switch self {
        case .login:
            return Constants.API.oauth.login
        case .validateToken:
            return Constants.API.oauth.validateToken
        }
    }

    var parameters: Parameters? {
        switch self {
        case .login(let params):
            return params
        case .validateToken:
            return nil
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        case .validateToken:
            return ["jwt" : (Keychain.shared[Constants.Keychain.token] ?? ""),
                    "resourceRequest" : "v1/es/cliente-fic",
                    "clientAction" : "GET"]
        case .login:
            return ["clientID" : "hola-mi-id-tyba",
                    "deviceType" : "web",
                    "ip" : "123"]
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try Constants.API.urlBase.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        urlRequest.method = method

        if let headers = headers {
            urlRequest.allHTTPHeaderFields = headers.dictionary
        }

        switch method {
        case .post:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .get:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            return urlRequest
        }
    }
}
