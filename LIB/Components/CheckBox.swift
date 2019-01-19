//
//  CheckBox.swift
//  stock-ios
//
//  Created by Thongpak on 18/10/2561 BE.
//  Copyright © 2561 thongpak. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "tick")! as UIImage
    let uncheckedImage = UIImage(named: "tick")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
