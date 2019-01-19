//
//  Validator.swift
//  stock-ios
//
//  Created by Thongpak on 11/10/2561 BE.
//  Copyright © 2561 thongpak. All rights reserved.
//

import Foundation


public class Validator {
    
    private var allowCharacters: String = ""
    private var minimumLength: Int = 0
    private var maximumLength: Int = 0
    
    public init() {
        
    }
    
    public func setAllowCharacterSet(characterSets: ValidatorCharacterSet ...) -> Validator {
        for each in characterSets {
            allowCharacters += each.getString()
        }
        return self
    }
    
    public func minimumLength(length: Int) -> Validator {
        self.minimumLength = length
        return self
    }
    
    public func maximumLength(length: Int) -> Validator {
        self.maximumLength = length
        return self
    }
    
    public func addAllowCharacters(characters: String) -> Validator {
        self.allowCharacters += characters
        return self
    }
    
    public func shouldChangeText(text: String, newString string: String, range: NSRange) -> Bool {
        
        let newLength = text.count + string.count - range.length
        let lessThanMaximum = newLength <= maximumLength
        let moreThanMinimum = newLength >= minimumLength
        
        let range = string.startIndex ..< string.endIndex
        let invalidCharacters = CharacterSet(charactersIn: allowCharacters).inverted
        let isValidCharacters = string.rangeOfCharacter(from: invalidCharacters, options: [], range: range) == nil
        
        return isValidCharacters && moreThanMinimum && lessThanMaximum
    }
    
    public func shouldChangeTextAllowAllCharacters(text: String, newString string: String, range: NSRange) -> Bool {
        
        let newLength = text.count + string.count - range.length
        let lessThanMaximum = newLength <= maximumLength
        let moreThanMinimum = newLength >= minimumLength
        
        return  moreThanMinimum && lessThanMaximum
    }
}

extension Validator {
    
    // MARK: Setter
    
    public func setMobileNumber() -> Validator {
        _ = self.setAllowCharacterSet(characterSets: .Numeric)
        _ = self.maximumLength(length: 10)
        return self
    }
    
    public func setOTPNumber() -> Validator {
        _ = self.setAllowCharacterSet(characterSets: .Numeric)
        _ = self.maximumLength(length: 4)
        return self
    }
    
    public func setIDCard() -> Validator {
        _ = self.setAllowCharacterSet(characterSets: .Numeric)
        _ = self.maximumLength(length: 13)
        return self
    }
    
    public func setIDCardOrPassport() -> Validator {
        _ = self.setAllowCharacterSet(characterSets: .Word)
        _ = self.maximumLength(length: 20)
        return self
    }
    
    public func setEmail() -> Validator {
        _ = self.maximumLength(length: 100)
        return self
    }
    
    public func setOTP() -> Validator {
        _ = self.setAllowCharacterSet(characterSets: .Numeric)
        _ = self.maximumLength(length: 4)
        return self
    }
    
    public func setPassword() -> Validator {
        /*
         * For password, allow user to input any characters
         * but alert then when text has invalid characters
         *
         self.setAllowCharacterSet(.Decimal, .LowercaseEnglishLetters, .UppercaseEnglishLetters)
         self.addAllowCharacters("@")
         self.maximumLength(10)
         */
        _ = self.maximumLength(length: 30)
        return self
    }
    
    // MARK: Getter
//    public func isValidIDCard(idCard: String) -> Bool {
//        guard idCard.isNumber() else { return false }
//
//        var sum = 0
//        let idCardStr = idCard as NSString
//
//        for i in 0...11 {
//            sum += idCardStr.substring(with: NSMakeRange(i, 1)).toInt()! * (13 - i)
//        }
//
//        if (11 - sum % 11) % 10 != idCardStr.substring(with: NSMakeRange(12, 1)).toInt()! {
//            return false
//        }
//
//        return true
//    }
    
    public func isMobile(text: String) -> Bool {
        return isMobileNumber(text: text) || isInternetNumber(text: text)
    }
    
    public func isMobileNumber(text: String) -> Bool {
        return text.hasPrefix("0") && isMobileOrInternetNumber(text: text)
    }
    
    public func isInternetNumber(text: String) -> Bool {
        return text.hasPrefix("88") && isMobileOrInternetNumber(text: text)
    }
    
    public func isOTP(text: String) -> Bool {
        return isNumber(text: text) && isValidText(text: text, withLength: 4)
    }
    
    public func isMobileOrInternetNumber(text: String) -> Bool {
        return isNumber(text: text) && isValidText(text: text, withLength: 10)
    }
    
    public func isNumber(text: String) -> Bool {
        let characterSet = ValidatorCharacterSet.Decimal.getString()
        let numberCharacters = CharacterSet(charactersIn: characterSet).inverted
        let noInvalidText = text.rangeOfCharacter(from: numberCharacters) == nil
        return noInvalidText
    }
    
    public func isValidText(text: String, withLength length: Int) -> Bool {
        return text.count == length
    }
}

extension Validator {
    
    public enum ValidatorCharacterSet {
        
        case Numeric
        case Decimal
        case UppercaseEnglishLetters
        case LowercaseEnglishLetters
        case Word
        func getString() -> String {
            switch self {
            case .Numeric:
                return "1234567890"
            case .Decimal:
                return "0123456789."
            case .UppercaseEnglishLetters:
                return "ABCDEFGHIJKLKMNOPQRSTUVWXYZ"
            case .LowercaseEnglishLetters:
                return "abcdefghijklmnopqrstuvwxyz"
            case .Word:
                return "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
            }
        }
    }
}
