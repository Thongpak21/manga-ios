//
//  ContentView.swift
//  Manga
//
//  Created by Thongpak on 4/4/2563 BE.
//  Copyright © 2563 Thongpak. All rights reserved.
//

import SwiftUI
import ASCollectionView
import Combine
import ActivityIndicatorView

struct MangaListView: View {
    @Environment(\.injected) private var injected: DIContainer
    @State private var routingState: Routing = .init()
    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: injected.appState, \.routing.newsMangas)
    }
    
    @State private var loadState: Loadable<[NewsManga]> = .notRequested
    var body: some View {
        NavigationView {
            self.content
                .navigationBarTitle("Manga", displayMode: .inline)
                .background(Color("Primary200"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(mangaUpdate) { self.loadState = $0 }
    }
    
    private var content: AnyView {
        switch loadState {
        case .notRequested: return AnyView(notRequestedView)
        case let .isLoading(last, _): return AnyView(loadingView(last))
        case let .loaded(mangas): return AnyView(loadedView(mangas, showSearch: true))
        case let .failed(error): return AnyView(failedView(error))
        }
    }
    
    
}

struct MangaListView_Previews: PreviewProvider {
    static var previews: some View {
        MangaListView().inject(.preview)
    }
}

// MARK: - Side Effects

private extension MangaListView {
    func loadMangas() {
        injected.interactors.mangaInterractor.loadNewsMangas()
    }
}

// MARK: - Loading Content

private extension MangaListView {
    var notRequestedView: some View {
        Text("Test").onAppear {
            self.loadMangas()
        }
    }
    
    func loadingView(_ previouslyLoaded: [NewsManga]?) -> some View {
        VStack {
            Text("teq")
        }
    }
    
    func failedView(_ error: Error) -> some View {
        VStack {
            Text("teq")
        }
    }
}



// MARK: - Displaying Content

private extension MangaListView {
    func loadedView(_ mangas: [NewsManga], showSearch: Bool) -> some View {
        
//        List(mangas, id: \.name) { item in
//            MangaCell(manga: item)
//        }
        ASCollectionView(data: mangas, dataID: \.self) { item, _ in
            MangaCell(manga: item)
            }
        .layout {
            .grid(layoutMode: .fixedNumberOfColumns(3),
                  itemSpacing: 7,
                  lineSpacing: 7,
                  itemSize: .estimated(200))
        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//            .edgesIgnoringSafeArea(.all)
    }
    
//    func detailsView(country: Country) -> some View {
//        CountryDetails(country: country)
//    }
}



// MARK: - Routing

extension MangaListView {
    struct Routing: Equatable {
        var mangaDetail: NewsManga?
    }
}

// MARK: - State Updates

private extension MangaListView {
    
    var routingUpdate: AnyPublisher<Routing, Never> {
        injected.appState.updates(for: \.routing.newsMangas)
    }

    var mangaUpdate: AnyPublisher<Loadable<[NewsManga]>, Never> {
        injected.appState.updates(for: \.userData.newsMangas)
    }
    
    var keyboardHeightUpdate: AnyPublisher<CGFloat, Never> {
        injected.appState.updates(for: \.system.keyboardHeight)
    }
}
