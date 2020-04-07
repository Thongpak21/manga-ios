//
//  AppEnvironment.swift
//  Manga
//
//  Created by Thongpak on 5/4/2563 BE.
//  Copyright © 2563 Thongpak. All rights reserved.
//

import UIKit
import Combine

struct AppEnvironment {
    let container: DIContainer
//    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())

        let session = configuredURLSession()
        let webRepositories = configuredWebRepositories(session: session)
        let interactors = configuredInteractors(appState: appState, webRepositories: webRepositories)
//        let systemEventsHandler = RealSystemEventsHandler(appState: appState)
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        return AppEnvironment(container: diContainer)
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }
    
    private static func configuredWebRepositories(session: URLSession) -> WebRepositoriesContainer {
        let mangaWebRepository = MangaRepository(
            session: session,
            baseURL: "http://www.thai-cartoon.com/wp")
        
        return WebRepositoriesContainer(mangaRepository: mangaWebRepository)
    }
    
    private static func configuredInteractors(appState: Store<AppState>,
                                              webRepositories: WebRepositoriesContainer
    ) -> DIContainer.Interactors {
        let mangaInteractor = MangaInteractor(
            webRepository: webRepositories.mangaRepository,
            appState: appState)
        return .init(mangaInterractor: mangaInteractor)
    }
}

private extension AppEnvironment {
    struct WebRepositoriesContainer {
        let mangaRepository: MangaRepositoryProtocol
    }
}
