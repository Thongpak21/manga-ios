//
//  MangaChapterTableViewCell.swift
//  MangaReader
//
//  Created by Thongpak on 20/1/2562 BE.
//  Copyright © 2562 Skydea. All rights reserved.
//

import UIKit

class MangaChapterTableViewCell: UITableViewCell {
    static let identifier = "MangaChapterTableViewCell"
    @IBOutlet weak var chapterNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
