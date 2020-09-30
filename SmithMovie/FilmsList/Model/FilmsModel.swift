//
//  FilmsModel.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 28.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import Foundation

// MARK: - Results

struct Results: Decodable {
    
    var page: Int?
    var total_pages: Int?
    var results: [Info]?
}

// MARK: - Info

struct Info: Decodable {
    
    var popularity: Double?
    var title: String?
    var poster_path: String?
    var overview: String?
    var vote_average: Double?
    var backdrop_path: String?
    var release_date: String?
    var id: Int?
    var vote_count: Int?
    var page: Int?
}
