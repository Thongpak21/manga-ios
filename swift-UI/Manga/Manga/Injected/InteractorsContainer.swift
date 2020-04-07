//
//  InteractorsContainer.swift
//  Manga
//
//  Created by Thongpak on 4/4/2563 BE.
//  Copyright © 2563 Thongpak. All rights reserved.
//

import Foundation

extension DIContainer {
    struct Interactors {
        let mangaInterractor: MangaInteractorProtocol

        init(mangaInterractor: MangaInteractorProtocol) {
            self.mangaInterractor = mangaInterractor
        }
        
        static var stub: Self {
            .init(mangaInterractor: StubMangaInteractor())
        }
    }
}
