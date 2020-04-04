//
//  AppView.swift
//  Manga
//
//  Created by Thongpak on 4/4/2563 BE.
//  Copyright © 2563 Thongpak. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            MangaView()
                .tabItem {
                    Image("ic_notification")
                    Text("Menu")
                }
            MangaView()
                .tabItem {
                    Image("ic_notification")
                    Text("Menu")
            }
        }.accentColor(.red)
    }
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
