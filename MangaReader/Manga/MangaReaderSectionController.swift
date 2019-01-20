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
        let processor = DownsamplingImageProcessor(size: cell.mangaImageView.bounds.size)
            >> RoundCornerImageProcessor(cornerRadius: 20)
        if let imageUrl = manga[index].img, let url = URL(string: imageUrl) {
//            cell.mangaImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1))])
            cell.mangaImageView.kf.setImage(with: url, placeholder: nil, options:  [
//                .processor(processor),
//                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
                ], progressBlock: {
                    receivedSize, totalSize in
                    let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
                    print("downloading progress: \(percentage)%")
//                    myIndicator.percentage = percentage
            })
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
