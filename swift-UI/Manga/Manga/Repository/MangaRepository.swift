//
//  MangaRepository.swift
//  Manga
//
//  Created by Thongpak on 5/4/2563 BE.
//  Copyright © 2563 Thongpak. All rights reserved.
//

import Foundation
import Combine

protocol MangaRepositoryProtocol: Repository {
    func loadNewsMangas() -> AnyPublisher<[NewsManga], Error>
//    func loadCountryDetails(country: Country) -> AnyPublisher<Country.Details.Intermediate, Error>
}


struct MangaRepository: MangaRepositoryProtocol {
    
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadNewsMangas() -> AnyPublisher<[NewsManga], Error> {
        return call(endpoint: API.newsMangas)
    }
    
//    func loadCountries() -> AnyPublisher<[Country], Error> {
//        return call(endpoint: API.allCountries)
//    }
//
//    func loadCountryDetails(country: Country) -> AnyPublisher<Country.Details.Intermediate, Error> {
//        let request: AnyPublisher<[Country.Details.Intermediate], Error> = call(endpoint: API.countryDetails(country))
//        return request
//            .tryMap { array -> Country.Details.Intermediate in
//                guard let details = array.first
//                    else { throw APIError.unexpectedResponse }
//                return details
//            }
//            .eraseToAnyPublisher()
//    }
}



// MARK: - Endpoints

extension MangaRepository {
    enum API {
        case newsMangas
    }
}

extension MangaRepository.API: APICall {
    var path: String {
        switch self {
        case .newsMangas:
            return "/showData.php"
        }
    }
    var method: String {
        switch self {
        case .newsMangas:
            return "GET"
        }
    }
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    func body() throws -> Data? {
        return nil
    }
}
