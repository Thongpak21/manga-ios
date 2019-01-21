//
//  MangaChapterViewController.swift
//  MangaReader
//
//  Created by Thongpak on 20/1/2562 BE.
//  Copyright © 2562 Skydea. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher
class MangaChapterViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var mangaName: String?
    var viewModel: MangaViewModel!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableView()
    }
    
    func setupViewModel() {
        viewModel = MangaViewModel()
        showLoading()
        viewModel.getMangaChapter(mangaName: mangaName ?? "onepiece").subscribe(onNext: { (_) in
            self.hideLoading()
            self.tableView.reloadData()
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
    }
    func setupTableView() {
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "readManga" {
            if let vc = segue.destination as? MangaReaderViewController, let sender = sender as? MangaChapterDetail {
                vc.mangaDetail = sender
            }
        }
    }
}

extension MangaChapterViewController: UITableViewDataSource {
    enum TableViewIndex: Int {
        case header, chapter
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableViewIndex(rawValue: section)! {
        case .header:
            return viewModel.mangaWithAllChapter.isEmpty ? 0: 1
        case .chapter:
            return viewModel.mangaWithAllChapter.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TableViewIndex(rawValue: indexPath.section)! {
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MangaChapterTitleTableViewCell.identifier, for: indexPath) as? MangaChapterTitleTableViewCell else { return UITableViewCell() }
            if let imageUrl = viewModel.mangaWithAllChapter[indexPath.row].cover, let url = URL(string: imageUrl) {
                cell.mangaImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1))])
            }
            cell.mangaNameLabel.text = viewModel.mangaWithAllChapter.first?.manga
            return cell

        case .chapter:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MangaChapterTableViewCell.identifier, for: indexPath) as? MangaChapterTableViewCell else  { return UITableViewCell() }
            if let chapter = viewModel.mangaWithAllChapter[indexPath.row].chapter, let chapterName = viewModel.mangaWithAllChapter[indexPath.row].name {
                cell.chapterNameLabel.text = "ตอนที่ \(chapter) \(chapterName)"
            }
            return cell
        }
    }
}

extension MangaChapterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch TableViewIndex(rawValue: indexPath.section)! {
        case .chapter:
            self.performSegue(withIdentifier: "readManga", sender: viewModel.mangaWithAllChapter[indexPath.row])
        default:
            break
        }
    }
}
