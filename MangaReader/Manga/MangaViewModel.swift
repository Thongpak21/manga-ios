//
//  MangaViewModel.swift
//  MangaReader
//
//  Created by Thongpak on 19/1/2562 BE.
//  Copyright © 2562 Skydea. All rights reserved.
//

import RxSwift

class MangaViewModel {
    var newsManga = [NewsMangaDetail]()
    var mangas = [MangaDetail]()
    var mangaWithAllChapter = [MangaChapterDetail]()
    func getNewsManga() -> Observable<Void?> {
        return Observable.create({ (observer) -> Disposable in
            let request = MangaManager().newsManga(completion: { (response) in
                self.newsManga = response
                observer.onNext(nil)
            }, failure: { (error) in
                
            })
            return Disposables.create {
                request?.cancel()
            }
        })
    }
    
    func getManga(name: String, chapter: String) -> Observable<Void?> {
        return Observable.create({ (observer) -> Disposable in
            let request = MangaManager().manga(mangaName: name, chapter: chapter, completion: { (response) in
                self.mangas = response
                observer.onNext(nil)
            }, failure: { (error) in
                
            })
            return Disposables.create {
                request?.cancel()
            }
        })
    }
    
    func getMangaChapter(mangaName: String) -> Observable<Void?> {
        return Observable.create({ (observer) -> Disposable in
            let request = MangaManager().mangaChapter(with: mangaName, completion: { (response) in
                self.mangaWithAllChapter = response
                observer.onNext(nil)
            }, failure: { (error) in
                
            })
            return Disposables.create {
                request?.cancel()
            }
        })
    }
}
