//
//  StyleTextManager.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 28/11/23.
//

import Foundation

struct StyleTextManager {
    
    //format dynamic when write 3 number insert dot
    static func formatNumber(_ number: String) -> String {
        // Eliminar cualquier formato existente primero
        let digitsOnly = number.replacingOccurrences(of: ".", with: "")
        
        let reversedDigits = digitsOnly.reversed()
        var formattedNumber = ""

        for (index, digit) in reversedDigits.enumerated() {
            if index % 3 == 0 && index != 0 {
                formattedNumber.append(".")
            }
            formattedNumber.append(digit)
        }

        return String(formattedNumber.reversed())
    }
}
