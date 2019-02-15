//
//  BaseTabBarViewController.swift
//  MangaReader
//
//  Created by Thongpak on 7/2/2562 BE.
//  Copyright © 2562 Skydea. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    func setTabBar() {
        //        tabBar.unselectedItemTintColor = YSColor.yellow.color()
        //        self.delegate = self
        let apperarance = UITabBarItem.appearance()
        let font = BaseFontSize.ExtraSmall.getFont()
        let attributes = [NSAttributedString.Key.font: font]
        apperarance.setTitleTextAttributes(attributes as Any as? [NSAttributedString.Key : Any], for: .normal)
        UITabBar.appearance().tintColor = UIColor.red
        self.tabBar.isTranslucent = false
    }
}
