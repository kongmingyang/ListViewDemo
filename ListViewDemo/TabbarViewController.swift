
//
//  TabbarViewController.swift
//  ListViewDemo
//
//  Created by 55it on 2019/1/16.
//  Copyright © 2019年 55it. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
    
        let item1 = ListViewController()
        
        item1.tabBarItem.image = UIImage.init(named: "2")
        item1.tabBarItem.title = "列表"
        let nav1 = UINavigationController.init(rootViewController: item1)
        
        let item2 = CollectionViewController()
        item2.tabBarItem.image = UIImage.init(named: "3")
        item2.tabBarItem.title = "collection"
        let nav2 = UINavigationController.init(rootViewController: item2)
        
        
        self.addChild(nav1)
        self.addChild(nav2)
        
        
    }
    

 

}
