//
//  NewMangaDetail.swift
//  MangaReader
//
//  Created by Thongpak on 19/1/2562 BE.
//  Copyright © 2562 Skydea. All rights reserved.
//

import Foundation
import IGListKit

class NewsMangaDetail: NSObject, Decodable {
    var last_chapter: String?
    var last_chapter1: Int?
    var last_chapter2: Int?
    var name: String?
    var cover: String?
    var slug: String?
    var last_update: String?
}

extension NewsMangaDetail: ListDiffable {
    public func diffIdentifier() -> NSObjectProtocol {
        return self as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? NewsMangaDetail else { return false }
        return self.name! == object.name!
    }
}


class MangaDetail: NSObject, Decodable {
    var id: Int?
    var img: String?
    var manga: String?
}

extension MangaDetail: ListDiffable {
    public func diffIdentifier() -> NSObjectProtocol {
        return self as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? MangaDetail else { return false }
        return self.id! == object.id!
    }
}

