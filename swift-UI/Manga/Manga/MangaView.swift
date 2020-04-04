//
//  ContentView.swift
//  Manga
//
//  Created by Thongpak on 4/4/2563 BE.
//  Copyright © 2563 Thongpak. All rights reserved.
//

import SwiftUI
import ASCollectionView

struct MangaView: View {
    
    @State var dataExample = (0 ..< 30).map { $0 }
    
    var body: some View {
        NavigationView {
            ASCollectionView(data: dataExample, dataID: \.self) { item, _ in
                Color.blue
                    .overlay(Text("\(item)"))
            }
            .layout {
                .grid(layoutMode: .adaptive(withMinItemSize: 100),
                      itemSpacing: 5,
                      lineSpacing: 5,
                      itemSize: .absolute(50))
            }.navigationBarTitle("Manga", displayMode: .inline)
        }
    }
}

struct MangaView_Previews: PreviewProvider {
    static var previews: some View {
        MangaView()
    }
}
