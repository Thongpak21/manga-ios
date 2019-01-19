//
//  StringExtensions.swift
//  CommonMyAIS
//
//  Created by Thongpak on 30/10/2560 BE.
//  Copyright © 2560 nextzy. All rights reserved.
//

import Foundation

public extension String {
    func isValidPhoneNumber() -> Bool {
        return self.count >= 9 && Int(self) != nil
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}


extension Int {
    func decimalNumber(fraction: Int = 0) -> String {
        let number = self
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = fraction
        return numberFormatter.string(for: number) ?? "---"
    }
}


extension Double {
    func decimalNumber(fraction: Int = 0) -> String {
        let number = self
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = fraction
        return numberFormatter.string(for: number) ?? "---"
    }
}
