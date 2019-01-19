//
//  Router+Params.swift
//  CommonMyAIS
//
//  Created by Kent Winder on 11/22/17.
//  Copyright © 2017 nextzy. All rights reserved.
//

extension Router {
    public var parameters: [String: Any]? {
        switch self {
        case .login(let params):
            return [
                "username": params.username,
                "password": params.password
            ]
        case .getToken(let token):
            return [
                "tokenID": token
            ]
            
        case .queryPartner(let params):
            return [
                "Name": params.name,
                "Value": params.value
            ]
        case .getMenu(let params):
            return [
                "locationCode": params.locationCode,
                "ascCode": params.ascCode
            ]
        default:
            return nil
        }
    }
}
