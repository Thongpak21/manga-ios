//
//  APIManager.swift
//  CommonMyAIS
//
//  Created by Kent Winder on 11/17/17.
//  Copyright © 2017 nextzy. All rights reserved.
//

import Alamofire

public class APIManager {
    public static let manager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [:]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        return Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
    
    @discardableResult static func request<Result: Decodable>(withRouter router: BaseRouter, responseType: Result.Type, completion: @escaping (_ result: Result) -> (), failure: @escaping (_ error: BaseError) -> ()) -> Request? {
        //        if !NetworkManager.isReachable() {
        //            NotificationCenter.default.post(name: Constants.NotificationName.noInternetConnection, object: nil)
        //        }
        //
        return manager.request(router)
            .logRequest()
            .responseData(completionHandler: { (response) in
                self.logResponse(response: response)
                switch response.result {
                case .success(let data):
                    do {
                        let resultObj = try JSONDecoder().decode(responseType, from: data)
                        if let statusCode = response.response?.statusCode, statusCode == 200 {
                            completion(resultObj)
                        } else {
                          failure(BaseError(message: "Can not connect Server"))
                        }
                    } catch {
                        failure(BaseError(message: "Can not connect Server"))
                    }
                    break
                case .failure(let error):
                    let error = BaseError(message: error.localizedDescription)
                    failure(error)
                    break
                }
            })
    }

    static func validate(statusCode code: Int) -> Bool {
        if code != 200 {
            return false
        }
        
        return true
    }
}
