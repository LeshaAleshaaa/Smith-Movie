//
//  URLList.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 28.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

//MARK: - URLList

enum URLList {
    
    static let apiKey: String = "a9208ac3c9fc83ffcde0d01af865a53a"
    static let urlFirstTitle: String = "https://api.themoviedb.org/3/movie/"
    static let urlTrailer: String = "https://www.youtube.com/watch?v="
    static let imageURL: String = "https://image.tmdb.org/t/p/original/"
    static let urlShareText: String = "https://www.themoviedb.org/movie/"
    static let basicApi: String = "\(urlFirstTitle)popular?api_key=\(apiKey)"
}
