//
//  String+Extension.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 27/11/23.
//

import Foundation

extension String {
    
    /// Returns true iff a String is empty or composed of spaces only.
    public func isBlank() -> Bool {
        
        let trimmed = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmed.isEmpty
    }
}

