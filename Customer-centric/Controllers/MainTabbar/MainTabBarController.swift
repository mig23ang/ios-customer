//
//  MainTabBarController.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 28/11/23.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    let indicator: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.8)
        view.frame.size = CGSize(width: (UIScreen.main.bounds.width / 3) - 20, height: 3)
        view.layer.cornerRadius = 1
        view.alpha = 0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }

    private func setupTabBar() {
        // Aquí puedes personalizar tu tabBar, por ejemplo:
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addGradientToTabBar()
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.cornerRadius = 16 // whatever you want
       // self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner] posible implementation
        tabBar.addSubview(indicator)
        animate(index: selectedIndex)
    }
    
    private func addGradientToTabBar() {
        let gradientlayer = CAGradientLayer()
        gradientlayer.frame = CGRect(x: 0, y: 0, width: tabBar.bounds.width,height: tabBar.bounds.height)
        gradientlayer.colors = [UIColor(named: "gradientGreen")!.cgColor, UIColor.black.cgColor]
        gradientlayer.locations = [0.3, 2]
           self.tabBar.layer.insertSublayer(gradientlayer, at: 0)
    }
    
    private func setupViewControllers() {
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Home"), selectedImage: UIImage(named: "Home"))

        let collectionViewController = CollectionViewController()
        collectionViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "collection"), selectedImage: UIImage(named: "collection"))
        
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "search"), selectedImage: UIImage(named: "search"))
        
        let navHomeVC = UINavigationController(rootViewController: homeViewController)
        let navCollectionVC = UINavigationController(rootViewController: collectionViewController)
        let navSearchVC = UINavigationController(rootViewController: searchViewController)
        
        viewControllers = [navHomeVC , navCollectionVC, navSearchVC]
        
        let tabBarItems = tabBar.items ?? []
        let offset: CGFloat = 5.0

        for tabBarItem in tabBarItems {
            tabBarItem.imageInsets = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0)
        }
    }
    
    private func animate(index: Int) {
        let buttons = tabBar.subviews
            .filter({ String(describing: $0).contains("Button") })
        
        guard index < buttons.count else {
            return
        }
        
        let selectedButton = buttons[index]
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                let point = CGPoint(
                    x: selectedButton.center.x,
                    y: selectedButton.frame.maxY - 7
                )
                
                self.indicator.center = point
            },
            completion: {_ in
                self.indicator.alpha = 1
            }
        )
    }
}

extension MainTabBarController : UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let items = tabBar.items,
              let index = items.firstIndex(of: item) else {
            return
        }
        animate(index: index)
    }
}
