//
//  SearchResponse.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 8/12/23.
//

import Foundation

struct SearchResponse: Decodable {
    var totalClientes: Int
    var clientes: [Client]
}
