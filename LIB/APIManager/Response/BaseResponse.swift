//
//  BaseResponse.swift
//  wallet
//
//  Created by Thongpak on 12/6/2561 BE.
//  Copyright © 2561 thongpak. All rights reserved.
//

import Foundation

class BaseResponse: NSObject, Decodable {
    var resultCode: String?
    var resultDescription: String?
    var developerMessage: String?
}

class BaseError: NSError {
    private let aisErrorDomain: String = "MyAISError"
    private let aisErrorCode: Int = 0
    
    public var resultCode: String {
        get {
            if let message = self.userInfo["resultCode"] as? String {
                return message
            }
            return ""
        }
    }
    
    public var message: String {
        get {
            if let message = self.userInfo["message"] as? String {
                return message
            }
            return ""
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        let userInfo = [
            "message": message
        ]
        super.init(domain: aisErrorDomain, code: aisErrorCode, userInfo: userInfo)
    }
    
    init(message: String, resultCode: String) {
        let userInfo = [
            "message": message,
            "resultCode": resultCode
        ]
        super.init(domain: aisErrorDomain, code: aisErrorCode, userInfo: userInfo)
    }
}
