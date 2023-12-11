//
//  APIInterceptor.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 7/12/23.
//

import Foundation
import Alamofire
import Combine
import UIKit

class AuthInterceptor: RequestInterceptor {

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        if Keychain.shared[Constants.Keychain.token] == nil {
            completion(.success(urlRequest))
            return
        }
        
        validateToken { isValid in
            if isValid {
                completion(.success(urlRequest))
            } else {
                //token invalid
                if let window = UIApplication.shared.currentWindow {
                    window.rootViewController = LoginViewController()
                }
            }
        }
    }

    func validateToken(completion: @escaping (Bool) -> Void) {
        
         let apiConfiguration = LoginAPI.validateToken
         AF.request(apiConfiguration).response { response in
             switch response.result {
             case .success:
                 if response.response?.statusCode == 200 {
                     completion(true)
                 } else {
                     completion(false)
                 }
             case .failure:
                 completion(false)
             }
         }
     }
}
