//
//  BaseNavigationViewController.swift
//  wallet
//
//  Created by Thongpak on 18/6/2561 BE.
//  Copyright © 2561 thongpak. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarFont()
        setNavigationBarProperties()
    }
    
    public func setNavBarFont() {
//        self.navigationBar.titleTextAttributes = [
//            NSAttributedString.Key.font : BaseFontSize.MediumBold.getFont(),
//            NSAttributedString.Key.foregroundColor : UIColor.black as Any]
//        UIBarButtonItem.appearance().setTitleTextAttributes([
//            NSAttributedString.Key.font : BaseFont.prompt.Medium(),
//            NSAttributedString.Key.foregroundColor: UIColor.brightBlue as Any], for: .normal)
//        UIBarButtonItem.appearance().setTitleTextAttributes([
//            NSAttributedString.Key.font : BaseFont.prompt.Medium(),
//            NSAttributedString.Key.foregroundColor: UIColor.softBlue as Any], for: .highlighted)
        self.navigationBar.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
    }
    
    public func setNavigationBarProperties() {
        self.navigationBar.barStyle     = UIBarStyle.default
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.tintColor    = UIColor.black
        self.navigationBar.isTranslucent  = false
    }
}


import UIKit

extension UISearchBar {
    
    func setFont() {
        
        for view : UIView in (self.subviews[0]).subviews {
            
            if let textField = view as? UITextField {
                textField.font = BaseFontSize.Medium.getFont()
                textField.textColor = UIColor.black
                textField.clearButtonMode = .whileEditing
                let attributes = [
                    NSAttributedString.Key.foregroundColor: UIColor.black,
                    NSAttributedString.Key.font : BaseFontSize.Medium.getFont()
                ]
                textField.attributedPlaceholder = NSAttributedString(string: "Search".localized(), attributes:attributes)
            }
        }
    } }
