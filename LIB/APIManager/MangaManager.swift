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
    
    @discardableResult
    func manga(mangaName: String, chapter: String, completion: @escaping ([MangaDetail]) -> (), failure: @escaping (BaseError) -> ()) -> Request? {
        let router = Router.readManga(name: mangaName, chapter: chapter)
        return APIManager.request(withRouter: router, responseType: [MangaDetail].self, completion: { (response) in
            completion(response)
        }, failure: { (error) in
            failure(error)
        })
    }

}

