//
//  AppView.swift
//  Manga
//
//  Created by Thongpak on 4/4/2563 BE.
//  Copyright © 2563 Thongpak. All rights reserved.
//

import SwiftUI

struct AppView: View {
    private let container: DIContainer
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        TabView {
            MangaListView().inject(container)
                .tabItem {
                    Image("ic_notification")
                    Text("Menu")
                }
        }.accentColor(.secondary)
    }
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(container: .preview)
    }
}
