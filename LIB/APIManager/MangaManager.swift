//
//  UserManagers.swift
//  wallet
//
//  Created by Thongpak on 6/7/2561 BE.
//  Copyright © 2561 thongpak. All rights reserved.
//

import Foundation
import Alamofire

class MangaManager {

    @discardableResult
    func newsManga(completion: @escaping ([NewsMangaDetail]) -> (), failure: @escaping (BaseError) -> ()) -> Request? {
        let router = Router.newManga
        return APIManager.request(withRouter: router, responseType: [NewsMangaDetail].self, completion: { (response) in
            completion(response)
        }, failure: { (error) in
            failure(error)
        })
    }

}

