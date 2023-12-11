//
//  APIService.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 6/12/23.
//

import Alamofire
import Combine
import Foundation
import UIKit

class APIService {
    
    static let shared = APIService()
    
    private let session: Session
    
    init() {
        let interceptor = AuthInterceptor()
        self.session = Session(interceptor: interceptor)
    }
    
    func requestPublisher<T: Decodable>(_ apiConfiguration: APIConfiguration) -> AnyPublisher<T, Error> {
        return session.request(apiConfiguration)
            .validate()
            .publishData()
            .tryMap { result in
                guard let data = result.data else {
                    throw APIError.otherError(result.error ?? AFError.explicitlyCancelled)
                }
                
                if let httpURLResponse = result.response, httpURLResponse.statusCode == 401 {
                    
                    // If the status is 401, try to get the error message from the text response
                    
                    if let window = UIApplication.shared.currentWindow {
                        window.rootViewController = LoginViewController()
                    }
                    if let responseString = String(data: data, encoding: .utf8) {
                        throw APIError.errorMessage(responseString)
                    } else {
                        throw APIError.tokenInvalido
                    }
                }
                do {
                    let value = try JSONDecoder().decode(T.self, from: data)
                    return value
                } catch {
                    // If decoding fails, try to get a text response
                    if let responseString = String(data: data, encoding: .utf8) {
                        throw APIError.errorMessage(responseString)
                    } else {
                        throw APIError.decodingError
                    }
                }
            }
            .eraseToAnyPublisher()
    }
}

enum APIError: Error {
    case decodingError
    case errorMessage(String)
    case otherError(AFError)
    case tokenInvalido
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Error al decodificar la respuesta."
        case .errorMessage(let message):
            return message
        case .otherError(let afError):
            return afError.localizedDescription
        case .tokenInvalido:
            return "No autorizado"
        }
    }
}
