//
//  MangaAllViewController.swift
//  MangaReader
//
//  Created by Thongpak on 21/1/2562 BE.
//  Copyright © 2562 Skydea. All rights reserved.
//

import UIKit
import RxSwift
import IGListKit

class MangaAllViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
        
    }()
    let searchController = UISearchController(searchResultsController: nil)
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
        title = "Manga"
        setupViewModel()
        setSearchController()
        setSearchIcon()
        setupCollectionView()
    }
    
    override func rightButtonAction() {
        searchController.searchBar.becomeFirstResponder()
    }
    
    func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        searchController.searchBar.setFont()
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
            navigationItem.titleView = searchController.searchBar
        }
        definesPresentationContext = true
        
        
        searchController.searchBar.rx.text.throttle(1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { (text) in
                self.viewModel.getAllManga(manga: text ?? "%").subscribe(onNext: { (_) in
//                            self.hideLoading()
                    self.adapter.reloadData(completion: nil)
                        }, onError: { (error) in
                
                        }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
    }
    
    func setupViewModel() {
        viewModel = MangaViewModel()
        showLoading()
        viewModel.getAllManga().subscribe(onNext: { (_) in
            self.hideLoading()
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
        viewModel.getNewsManga().subscribe(onNext: { (_) in
            self.adapter.reloadData(completion: nil)
            self.refreshControl.endRefreshing()
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
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

extension MangaAllViewController: ListAdapterDataSource {
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
        return Bundle.main.loadNibNamed("EmptyView", owner: self, options: nil)?.first as? UIView
    }
}


extension MangaAllViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}
