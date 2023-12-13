//
//  Client.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 8/12/23.
//

import Foundation

struct Client: Decodable, Equatable {
    var tipoDocumento: String
    var numeroDocumento: String
    var nombreCompleto: String
    var fechaUltimaActualizacion: String
    var paisOrigen: String
}
