//
//  MangaInteractor.swift
//  Manga
//
//  Created by Thongpak on 5/4/2563 BE.
//  Copyright © 2563 Thongpak. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

protocol MangaInteractorProtocol {
    func loadNewsMangas()
}

struct MangaInteractor: MangaInteractorProtocol {
    
    let webRepository: MangaRepositoryProtocol
    let appState: Store<AppState>
    
    init(webRepository: MangaRepositoryProtocol, appState: Store<AppState>) {
        self.webRepository = webRepository
        self.appState = appState
    }
    
    func loadNewsMangas() {
        let newsMangas = appState.value.userData.newsMangas.value
        let cancelBag = CancelBag()
        appState[\.userData.newsMangas] = .isLoading(last: newsMangas, cancelBag: cancelBag)
        weak var weakAppState = appState
        webRepository.loadNewsMangas()
            .sinkToLoadable { weakAppState?[\.userData.newsMangas] = $0 }
            .store(in: cancelBag)
    }
}

struct StubMangaInteractor: MangaInteractorProtocol {
    
    func loadNewsMangas() {
        
    }
}
