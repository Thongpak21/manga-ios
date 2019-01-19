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
}
