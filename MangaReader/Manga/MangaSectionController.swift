//
//  MangaSectionController.swift
//  MangaReader
//
//  Created by Thongpak on 19/1/2562 BE.
//  Copyright © 2562 Skydea. All rights reserved.
//

import Foundation
import IGListKit
import Kingfisher

class MangaSectionController: ListSectionController {
    
    var newsManga = [NewsMangaDetail]()
    override func numberOfItems() -> Int {
        return newsManga.count
    }
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return itemSize()
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCellFromStoryboard(withIdentifier: "MangaCollectionViewCell", for: self, at: index) as! MangaCollectionViewCell
        if let imageUrl = newsManga[index].cover, let url = URL(string: imageUrl) {
            cell.mangaImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1))])
        }
        cell.nameLabel.text = newsManga[index].name

//        cell.mangaImageView.backgroundColor = UIColor.black
        return cell
    }
    
    func itemSize() -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width / 3 - 7, height: 180)
    }
    
    override func didUpdate(to object: Any) {
    }
    
    
    override func didSelectItem(at index: Int) {
        guard let vc = viewController as? MangaViewController else { return }
        vc.performSegue(withIdentifier: "showMangaChapter", sender: newsManga[index])
    }
    
}
