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
    
    var title: String?
    var poster_path: String?
    var overview: String?
    var vote_average: Double?
    var id: Int?
    var page: Int?
}
