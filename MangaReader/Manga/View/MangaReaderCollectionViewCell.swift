//
//  MangaReaderCollectionViewCell.swift
//  MangaReader
//
//  Created by Thongpak on 20/1/2562 BE.
//  Copyright © 2562 Skydea. All rights reserved.
//

import UIKit
import MaterialComponents

class MangaReaderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mangaImageView: UIImageView!
    let activityIndicator = MDCActivityIndicator()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.sizeToFit()
        activityIndicator.center = CGPoint(x: mangaImageView.bounds.midX, y: mangaImageView.bounds.midY)
        activityIndicator.indicatorMode = .determinate
        activityIndicator.cycleColors = [.blue, .red, .cyan]
        mangaImageView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
}
