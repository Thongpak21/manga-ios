//
//  BaseButton.swift
//  
//
//  Created by Thongpak on 12/6/2561 BE.
//

import UIKit

class BaseButton: UIButton {
    @IBInspectable var key: String?
    @IBInspectable var fontSize: String?
    deinit {
        self.removeObserver()
    }
    
    override public func awakeFromNib() {
        self.localizeButton()
        self.setInterface()
        self.addObserver()
        setButtonBorder()
    }

    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(BaseButton.localizeButton), name: NSNotification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func localizeButton() {
        if let key = self.key {
            let title = key.localized()
            self.setTitle(title, for: .normal)
            self.fadeAnimation()
        }
    }
    
//    func setCancelButton() {
//        self.setTitleColor(UIColor.brownishGrey, for: .normal)
//        self.setTitleColor(UIColor.coolGrey, for: .highlighted)
//    }
//
//    func setOkButton() {
//        self.setTitleColor(UIColor.white, for: .normal)
//        self.setTitleColor(UIColor.white, for: .highlighted)
//        self.setBackgroundColor(color: UIColor.brightBlue, forState: .normal)
//        self.setBackgroundColor(color: UIColor.softBlue, forState: .highlighted)
//    }
//
    func setGreenButton() {
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.white, for: .highlighted)
//        self.setBackgroundColor(color: UIColor.darkGreen, forState: .normal)
//        self.setBackgroundColor(color: UIColor.darkGreen.withAlphaComponent(0.6), forState: .highlighted)
    }
//
//    func setRedButton() {
//        self.setTitleColor(UIColor.white, for: .normal)
//        self.setTitleColor(UIColor.white, for: .highlighted)
//        self.titleLabel?.textColor = UIColor.white
//        self.setBackgroundColor(color: UIColor.watermelon, forState: .normal)
//        self.setBackgroundColor(color: UIColor.watermelon.withAlphaComponent(0.9), forState: .highlighted)
//    }
    
    func setInterface() {
        self.setFontSize()
    }
    
    public var _fontSize: BaseFontSize {
        if let fontStyle = self.fontSize {
            if fontStyle.lowercased().contains("extrasmall") {
                return .ExtraSmall
            }
            if fontStyle.lowercased().contains("small") {
                return .Small
            }
            if fontStyle.lowercased().contains("mediumbold") {
                return .MediumBold
            }
            if fontStyle.lowercased().contains("medium") {
                return .Medium
            }
            if fontStyle.lowercased().contains("extralarge") {
                return .ExtraLarge
            }
            if fontStyle.lowercased().contains("large") {
                return .Large
            }
        }
        return .Small
    }
    
    public func setFontSize() {
        switch _fontSize {
        case .ExtraSmall:
            self.titleLabel?.font = BaseFontSize.ExtraSmall.getFont()
            break
        case .Small:
            self.titleLabel?.font = BaseFontSize.Small.getFont()
            break
        case .Medium:
            self.titleLabel?.font = BaseFontSize.Medium.getFont()
            break
        case .Large:
            self.titleLabel?.font = BaseFontSize.Large.getFont()
            break
        case .ExtraLarge:
            self.titleLabel?.font = BaseFontSize.ExtraLarge.getFont()
            break
        case .LargeBold:
            self.titleLabel?.font = BaseFontSize.LargeBold.getFont()
            break
        case .MediumBold:
            self.titleLabel?.font = BaseFontSize.MediumBold.getFont()
        }
    }
    
    func setButtonBorder() {
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
    }
}
