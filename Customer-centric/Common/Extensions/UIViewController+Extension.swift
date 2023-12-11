//
//  UIViewController+Extension.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 4/12/23.
//

import Foundation
import UIKit

extension UIViewController {
    static func returnPresentedViewController() -> UIViewController {
        
        guard let rootViewController : UIViewController = UIApplication.shared.keyWindow?.rootViewController else {
            fatalError("there is no view controller presented on screen.")
        }
        //if rootViewController is a tab bar controller
        if let tabBar = rootViewController as? UITabBarController,
            let selectedViewController = tabBar.selectedViewController {
            
            if let presentedViewController = selectedViewController.presentedViewController  {
                return presentedViewController
            }
            //if its a nav controller.
            if let navController = selectedViewController as? UINavigationController,
                let lastVC = navController.viewControllers.last{
                
                if let presentedViewController = lastVC.presentedViewController  {
                    return presentedViewController
                }
                
                return lastVC
            }
            return selectedViewController
        }
        
        if let navController = rootViewController as? UINavigationController,
            let lastVC = navController.viewControllers.last{
            if let presentedViewController = lastVC.presentedViewController  {
                return presentedViewController
            }
            return lastVC
        }

        guard let presentedViewController = rootViewController.presentedViewController else {
            return rootViewController
        }
        
        return presentedViewController
    }
}
