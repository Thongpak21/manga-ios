//
//  BaseFont.swift
//  wallet
//
//  Created by Thongpak on 13/6/2561 BE.
//  Copyright © 2561 thongpak. All rights reserved.
//

import UIKit

public enum BaseFontSize {
    case ExtraSmall
    case Small
    case Medium
    case MediumBold
    case Large
    case ExtraLarge
    case LargeBold
    public func getFont() -> UIFont {
        switch self {
        case .ExtraSmall:
            return BaseFont.helvetica.ExtraSmall()
        case .Small:
            return BaseFont.helvetica.Small()
        case .Medium:
            return BaseFont.helvetica.Medium()
        case .MediumBold:
            return BaseFont.helvetica.MediumBold()
        case .Large:
            return BaseFont.helvetica.Large()
        case .ExtraLarge:
            return BaseFont.helvetica.ExtraLarge()
        case .LargeBold:
            return BaseFont.helvetica.LargeBold()
        }
    }
}


public enum BaseFont {
    case helvetica
    
    static let xSmall:  CGFloat = 10
    static let small:   CGFloat = 12
    static let medium:  CGFloat = 15
    static let large:   CGFloat = 17
    static let xLarge:  CGFloat = 24
    static let passCode: CGFloat = 30
    // Extra Small size
    
    public func ExtraSmall() -> UIFont {
        let size = BaseFont.xSmall
        let type = FontType.Regular
        return withSize(size: size, type: type)
    }
    
    public func ExtraSmallBold() -> UIFont {
        let size = BaseFont.xSmall
        let type = FontType.Bold
        return withSize(size: size, type: type)
    }
    
    // Small size
    
    public func Small() -> UIFont {
        let size = BaseFont.small
        let type = FontType.Regular
        return withSize(size: size, type: type)
    }
    
    public func SmallBold() -> UIFont {
        let size = BaseFont.small
        let type = FontType.Bold
        return withSize(size: size, type: type)
    }
    
    // Medium size
    
    public func Medium() -> UIFont {
        let size = BaseFont.medium
        let type = FontType.Regular
        return withSize(size: size, type: type)
    }
    
    public func MediumBold() -> UIFont {
        let size = BaseFont.medium
        let type = FontType.Bold
        return withSize(size: size, type: type)
    }
    
    // Large size
    
    public func Large() -> UIFont {
        let size = BaseFont.large
        let type = FontType.Regular
        return withSize(size: size, type: type)
    }
    
    public func LargeBold() -> UIFont {
        let size = BaseFont.large
        let type = FontType.Bold
        return withSize(size: size, type: type)
    }
    
    // Extra large
    
    public func ExtraLarge() -> UIFont {
        let size = BaseFont.xLarge
        let type = FontType.Regular
        return withSize(size: size, type: type)
    }
    
    public func ExtraLargeBold() -> UIFont {
        let size = BaseFont.xLarge
        let type = FontType.Bold
        return withSize(size: size, type: type)
    }
    
    public func passCode() -> UIFont {
        let size = BaseFont.passCode
        let type = FontType.Regular
        return withSize(size: size, type: type)
    }
    
    // Customize
    
    public func withSize(size: CGFloat, type: FontType) -> UIFont {
        switch self {
        case .helvetica:
            return UIFont.Font(FontName.Helvetica, type: type, size: size)
        }
    }
    
}
