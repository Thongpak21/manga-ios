//
//  MangaAllViewController.swift
//  MangaReader
//
//  Created by Thongpak on 21/1/2562 BE.
//  Copyright © 2562 Skydea. All rights reserved.
//

import UIKit
import RxSwift

class MangaAllViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: MangaViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupViewModel() {
        viewModel = MangaViewModel()
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}
