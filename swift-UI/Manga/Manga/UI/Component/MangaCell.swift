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
    let manga: NewsManga

    var body: some View {
        VStack(alignment: .center, spacing: nil) {
            KFImage(URL(string: self.manga.cover ?? "")!)
                .resizable()
                .clipped()
            Text(manga.name ?? "")
                .font(.system(size: 16, weight: .regular))
                .lineLimit(2)
        }
    .padding(0)
        .background(Color.white)
        .cornerRadius(5)
    }
}

struct MangaCell_Previews: PreviewProvider {
    static var previews: some View {
        MangaCell(manga: NewsManga.mockedData[0])
    }
}

