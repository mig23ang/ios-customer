//
//  APIConstants.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 6/12/23.
//

import Foundation

extension Constants {
    
    struct API {
        
        static let urlBase = App.getValueFromInfoPlist(with: "urlBase")
        
        struct oauth {
            static let login = "v1/ms/acceso/autentica/usuario/"
            static let validateToken = "v1/ms/acceso/verifica/usuario/"
            static let searchByName = "v1/es/cliente-fic/nombre/"
            static let searchByDocument = "v1/es/cliente-fic/"
        }
    }
}


