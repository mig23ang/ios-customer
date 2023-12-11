//
//  Paginator.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 7/12/23.
//

import Foundation

struct Paginator {
    var page: Int
    var pageSize: Int

    mutating func incrementPage() {
        self.page += 1
    }
}
