//
//  UIApplication+Extension.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 28/11/23.
//

import Foundation
import UIKit

extension UIApplication {
    var currentWindow: UIWindow? {
        return self.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .filter { $0.isKeyWindow }.first
    }
}
