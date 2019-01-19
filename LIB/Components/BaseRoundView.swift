//
//  BaseRoundView.swift
//  wallet
//
//  Created by Thongpak on 19/6/2561 BE.
//  Copyright © 2561 thongpak. All rights reserved.
//

import UIKit

class BaseRoundView: UIView {
    @IBInspectable var _borderWidth: NSNumber?
    @IBInspectable var _borderColor: UIColor?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setInterface()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setInterface()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.setInterface()
        self.layoutIfNeeded()
    }
    
    public override func prepareForInterfaceBuilder() {
        self.setInterface()
    }
    
    // Interface
    
    func setInterface() {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        if let color = _borderColor {
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = 1
        }
    }
}


class BaseView: UIView {
    @IBInspectable var _borderColor: UIColor?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setInterface()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setInterface()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.setInterface()
        self.layoutIfNeeded()
    }
    
    public override func prepareForInterfaceBuilder() {
        self.setInterface()
    }
    
    // Interface
    
    func setInterface() {
        self.clipsToBounds = true
        if let color = _borderColor {
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = 1
        }
    }
}
