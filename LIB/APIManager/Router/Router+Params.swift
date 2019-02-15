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
        case .readManga(let params):
            return [
                "manganame": params.name,
                "chapter": params.chapter
            ]
        case .mangaChapter(let name):
            return [
                "manganame": name
            ]
        case .allManga(let manga):
            return [
                "sort": manga + "%"
            ]
        default:
            return nil
        }
    }
}
