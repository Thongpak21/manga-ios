//
//  Router+Path.swift
//  CommonMyAIS
//
//  Created by Kent Winder on 11/20/17.
//  Copyright © 2017 nextzy. All rights reserved.
//


extension Router {
    //TODO
    public var path: String {
        switch self {
        case .login:
            return "/api/auth/ids"
        case .getToken:
            return "/api/auth/login-asp"
        case .queryPartner:
            return "/api/easyapp/queryPartnerInfoByLocationCode"
        case .refreshToken:
            return "/api/auth/refreshToken"
        case .getMenu:
            return "/api/easyapp/get-menu-by-user-role"
        }
    }
}
