//
//  TrailersModel.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 11.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import Foundation

// MARK: - Trailers

struct Trailers: Decodable {
    var results: [TrailerKey]?
}

// MARK: - TrailerKey

struct TrailerKey: Decodable {
    var key: String?
}
