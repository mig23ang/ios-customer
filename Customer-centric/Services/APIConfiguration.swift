//
//  APIConfiguration.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 6/12/23.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var headers : HTTPHeaders? { get }
}
