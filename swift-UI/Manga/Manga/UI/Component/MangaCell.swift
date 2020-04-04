//
//  MangaCell.swift
//  Manga
//
//  Created by Thongpak on 5/4/2563 BE.
//  Copyright © 2563 Thongpak. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct MangaCell: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil) {
            KFImage(URL(string: "https://example.com/image.png")!)
            Text("Test")
        }
    }
}

struct MangaCell_Previews: PreviewProvider {
    static var previews: some View {
        MangaCell()
    }
}

