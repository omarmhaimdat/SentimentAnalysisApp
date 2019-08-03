//
//  MainTabViewController.swift
//  SentimentAnalysisApp
//
//  Created by M'haimdat omar on 03-08-2019.
//  Copyright © 2019 M'haimdat omar. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        tabBar.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 0.1)
        tabBar.unselectedItemTintColor = UIColor.lightGray
        tabBar.isTranslucent = true
    }
    
    func setupTabBar() {
        
        let vc = ViewController()
        
        let viewController = UINavigationController(rootViewController: vc)
        viewController.tabBarItem.image = UIImage(named: "review")
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 1, left: 0, bottom: -1, right: 0)
        viewController.tabBarItem.title = "Reviews"
        
        viewControllers = [viewController]
        
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        let navigation = UINavigationBar.appearance()
        
        let navigationFont = UIFont(name: "Avenir", size: 20)
        let navigationLargeFont = UIFont(name: "Avenir-Heavy", size: 34)
        
        navigation.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: navigationFont!]
        
        if #available(iOS 11, *) {
            navigation.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: navigationLargeFont!]
        }
    }
}
