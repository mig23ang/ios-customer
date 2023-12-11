//
//  Validation.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 6/12/23.
//

import Foundation

open class Validation {
    
    public static let shared = Validation()
    
    ///Returns a bool for define if the email format its correct
    public func validateEmailFormat(withText text: String) -> Bool{
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
}
