//
//  NetworkLayer.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 14.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import Foundation
import Moya

//MARK: - NetworkLayer

final class NetworkLayer: INetworkLayer {
    
    let provider = MoyaProvider<MoyaExampleService>()
    
    func getFilms(page: Int, baseApi: String, complition: @escaping (Results) -> Void) {
        provider.request(.getFilms(page: page, baseApi: baseApi)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let filter = try response.filterSuccessfulStatusCodes()
                    let user = try filter.map(Results.self)
                    complition(user)
                }
                catch let error {
                    print("Error \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getTrailers(for id: Int, complition: @escaping (Trailers) -> Void) {
        provider.request(.getTrailers(id: id)) { (trailers) in
            switch trailers {
            case let .success(response):
                do {
                    let filter = try response.filterSuccessfulStatusCodes()
                    let user = try filter.map(Trailers.self)
                    complition(user)
                }
                catch let error {
                    print("Error \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getFilmInfo(for id: Int, complition: @escaping (Info) -> Void) {
        provider.request(.getInfo(id: id)) { (info) in
            switch info {
            case let .success(response):
                do {
                    let filter = try response.filterSuccessfulStatusCodes()
                    let user = try filter.map(Info.self)
                    complition(user)
                }
                catch let error {
                    print("Error \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
