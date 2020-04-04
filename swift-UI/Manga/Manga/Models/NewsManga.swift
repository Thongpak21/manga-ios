//
//  NewsManga.swift
//  Manga
//
//  Created by Thongpak on 5/4/2563 BE.
//  Copyright © 2563 Thongpak. All rights reserved.
//

import Foundation

struct NewsManga: Codable {
    var lastChapter: String?
    var lastChapter1: Int?
    var lastChapter2: Int?
    var name: String?
    var cover: String?
    var slug: String?
    var lastUpdate: String?
    
    private enum CodingKeys: String, CodingKey {
        case lastChapter = "last_chapter"
        case lastChapter1 = "last_chapter1"
        case lastChapter2 = "last_chapter2"
        case name
        case cover
        case slug
        case lastUpdate = "last_update"
    }
}
