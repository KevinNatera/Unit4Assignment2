//
//  TabBarViewController.swift
//  Unit4Assignment2
//
//  Created by Kevin Natera on 10/13/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUp()
      
    }
    
    private func setUp() {
        self.delegate = self as? UITabBarControllerDelegate
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let tabOneVC = storyboard.instantiateViewController(withIdentifier: "ViewController")
              let tabTwoVC = FavoriteViewController()
              tabOneVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "cloud.bolt.fill"), tag: 0)
              tabTwoVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart.fill"), tag: 1)
              let viewControllerList = [tabOneVC,tabTwoVC]
              self.viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
    }


}


