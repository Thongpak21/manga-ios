//
//  ViewController.swift
//  MangaReader
//
//  Created by Thongpak on 19/1/2562 BE.
//  Copyright © 2562 Skydea. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift

class MangaViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    let disposeBag = DisposeBag()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    var viewModel: MangaViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Manga ล่าสุด"
        setupViewModel()
        setupCollectionView()
    }
    
    func setupViewModel() {
        viewModel = MangaViewModel()
        viewModel.getNewsManga().subscribe(onNext: { (_) in
            self.adapter.reloadData(completion: nil)
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
    }
    func setupCollectionView() {
        self.collectionView.refreshControl = refreshControl
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "showMangaChapter" {
            if let manga = sender as? NewsMangaDetail, let vc = segue.destination as? MangaChapterViewController {
                vc.mangaName = manga.slug
            }
        }
    }
}

extension MangaViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        if viewModel.newsManga.isEmpty {
            return [ListDiffable]()
        } else {
            return [1 as ListDiffable]
        }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = MangaSectionController()
        sectionController.newsManga = viewModel.newsManga
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
