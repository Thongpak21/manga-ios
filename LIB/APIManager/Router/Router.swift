//
//  Router.swift
//  CommonMyAIS
//
//  Created by Kent Winder on 11/20/17.
//  Copyright © 2017 nextzy. All rights reserved.
//

import Alamofire

public protocol BaseRouter: URLRequestConvertible {
    var apiUrl: String { get }
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

public enum Router: BaseRouter {
    case login(username: String, password: String)
    case getToken(token: String)
    case getMenu(locationCode: String, ascCode: String)
    case queryPartner(name: String, value: String)
    case refreshToken
}

extension Router {
    public var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
    
    public var apiUrl: String {
        switch self {
        default:
            return Constants.environment.apiEndPoint
        }
    }
    
    var urlPath: String {
        return apiUrl + path
    }
    
}

