//
//  MangaReaderSectionController.swift
//  MangaReader
//
//  Created by Thongpak on 20/1/2562 BE.
//  Copyright © 2562 Skydea. All rights reserved.
//

import Foundation
import IGListKit
import Kingfisher

class MangaReaderSectionController: ListSectionController {
    
    var manga = [MangaDetail]()
    override func numberOfItems() -> Int {
        return manga.count
    }
    
    override init() {
        super.init()
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return itemSize()
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCellFromStoryboard(withIdentifier: "MangaReaderCollectionViewCell", for: self, at: index) as! MangaReaderCollectionViewCell
        if let imageUrl = manga[index].img, let url = URL(string: imageUrl) {
            cell.mangaImageView.kf.setImage(with: url, placeholder: nil, options:  [
                .transition(.fade(1)),
                .cacheOriginalImage
                ], progressBlock: {
                    receivedSize, totalSize in
                    let percentage = (Float(receivedSize) / Float(totalSize))
                    cell.activityIndicator.progress = percentage
                    cell.activityIndicator.startAnimating()
                    if percentage == 1.0 {
                        cell.activityIndicator.stopAnimating()
                    }
            }) { (_) in
                cell.activityIndicator.stopAnimating()
            }
        }
        if index + 1 < manga.count, let imageUrl = manga[index+1].img, let url = URL(string: imageUrl) {
            let _ = UIImageView().kf.setImage(with: url, placeholder: nil, options:  [.transition(.fade(1)),.cacheOriginalImage])
        }
        if index + 2 < manga.count, let imageUrl = manga[index+2].img, let url = URL(string: imageUrl) {
            let _ = UIImageView().kf.setImage(with: url, placeholder: nil, options:  [.transition(.fade(1)),.cacheOriginalImage])
        }
        return cell
    }
    
    func itemSize() -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: collectionContext!.containerSize.height)
    }
    
    override func didUpdate(to object: Any) {
    }
    
    
    override func didSelectItem(at index: Int) {
    }
    
}
