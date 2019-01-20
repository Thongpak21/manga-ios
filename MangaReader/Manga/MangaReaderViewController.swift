//
//  MangaReaderViewController.swift
//  MangaReader
//
//  Created by Thongpak on 20/1/2562 BE.
//  Copyright © 2562 Skydea. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift

class MangaReaderViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    let disposeBag = DisposeBag()

    var viewModel: MangaViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupCollectionView()
    }
    
    func setupViewModel() {
        viewModel = MangaViewModel()
        viewModel.getManga().subscribe(onNext: { (_) in
            self.adapter.reloadData(completion: nil)
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
    }
    func setupCollectionView() {
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
}

extension MangaReaderViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        if viewModel.mangas.isEmpty {
            return [ListDiffable]()
        } else {
            return [1 as ListDiffable]
        }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = MangaReaderSectionController()
        sectionController.manga = viewModel.mangas
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
