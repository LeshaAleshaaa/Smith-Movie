//
//  INetworkLayer.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 13.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

//MARK: - INetworkLayer

protocol INetworkLayer {
    
    func getTrailers(for id: Int, complition: @escaping (Trailers) -> Void)
    func getFilmInfo(for id: Int, complition: @escaping (Info) -> Void)
    func getFilms(page: Int, baseApi: String, complition: @escaping (Results) -> Void)
}
