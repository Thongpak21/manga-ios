//
//  MangaCollectionViewCell.swift
//  MangaReader
//
//  Created by Thongpak on 19/1/2562 BE.
//  Copyright © 2562 Skydea. All rights reserved.
//

import UIKit

class MangaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mangaImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var updateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 7
        self.clipsToBounds = true
    }
}
