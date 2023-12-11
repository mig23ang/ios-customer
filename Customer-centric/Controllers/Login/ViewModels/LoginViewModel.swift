//
//  LoginViewModel.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 28/11/23.
//

import Foundation
import Combine
import Alamofire

class LoginViewModel: ObservableObject {
    
    var loginPublisher: AnyPublisher<Token, Error>?

    func login(username: String, password: String) -> AnyPublisher<Token, Error> {
        let parameters: Parameters = ["correo": username, "clave": password]
        return APIService.shared
               .requestPublisher(LoginAPI.login(parameters: parameters))
               .eraseToAnyPublisher()
    }
    
}
