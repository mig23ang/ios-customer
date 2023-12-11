//
//  UIButton+Extension.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 27/11/23.
//

import UIKit

extension UIButton {
    func addUnderline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: text.count)
        )
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    func select() {
        self.titleLabel?.font = .systemFont(ofSize: (self.titleLabel?.font.pointSize)!, weight: .bold)
    }

    func deselect() {
        self.titleLabel?.font = .systemFont(ofSize: (self.titleLabel?.font.pointSize)!, weight: .light)
    }
}
