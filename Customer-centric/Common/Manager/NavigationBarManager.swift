//
//  NavigationBarManager.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 28/11/23.
//

import Foundation
import UIKit

class NavigationBarManager {
    static let shared = NavigationBarManager()
    
    private init() {}
    
    var badgeCount: Int = 12 {
        didSet {
            updateBadgeCountOnBarButton()
        }
    }
    
    weak var rightBarButton: UIButton?
    
    func setupRightBarButton(on navigationItem: UINavigationItem) {
        let notificationButton = UIButton(type: .custom)
        notificationButton.setImage(UIImage(named: "Bell"), for: .normal)
        notificationButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        rightBarButton = notificationButton
        
        let badgeLabel = UILabel(frame: CGRect(x: 18, y: -3, width: 18, height: 18))
        badgeLabel.tag = 99
        badgeLabel.backgroundColor = .red
        badgeLabel.layer.cornerRadius = badgeLabel.bounds.size.height / 2
        badgeLabel.layer.masksToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.textColor = .white
        badgeLabel.font = UIFont.systemFont(ofSize: 10)
        
        notificationButton.addSubview(badgeLabel)
        updateBadgeCountOnBarButton()
        
        let barButtonItem = UIBarButtonItem(customView: notificationButton)
        navigationItem.rightBarButtonItems?.append(barButtonItem)
    }
    
    func updateBadgeCountOnBarButton() {
        DispatchQueue.main.async {
            guard let badgeLabel = self.rightBarButton?.viewWithTag(99) as? UILabel else { return }
            badgeLabel.text = "\(self.badgeCount)"
            badgeLabel.isHidden = self.badgeCount == 0
        }
    }
    
    @objc private func notificationButtonTapped() {
       
    }
}
