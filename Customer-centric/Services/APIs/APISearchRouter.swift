//
//  APISearchRouter.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 7/12/23.
//

import Foundation
import Alamofire
import UIKit

enum APISearchRouter: APIConfiguration {
    
    case searchByDocument(documentType: String, documentNumber: String, digitVerification: String)
    case searchByName(name: String, paginator: Paginator)
 
    var method: HTTPMethod {
        switch self {
        case .searchByDocument, .searchByName:
            return .get
        }
    }

    var path: String {
        switch self {
        case .searchByDocument(let documentType, let documentNumber, let digitVerification):
            return Constants.API.oauth.searchByDocument + "\(documentType)/\(documentNumber)/\(digitVerification)"
        case .searchByName(let name, _):
            return Constants.API.oauth.searchByName + "\(name)"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .searchByDocument:
            return nil
        case .searchByName(_, let paginator):
            var allParams = Parameters()
            allParams["page"] = paginator.page
            allParams["pageSize"] = paginator.pageSize
            return allParams
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        case .searchByDocument, .searchByName:
            return ["jwt" : (Keychain.shared[Constants.Keychain.token] ?? "")]
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

