//
//  ParsingResults.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 30.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import UIKit

// MARK: - Parsing Film Info

final class FilmInfoParsing {
    
    // MARK: - Private properties
    
    private var parsingResults: INetworkLayer?
    
    // MARK: - Public methods
    
    public func loadFilmInfoData(id: Int?, complition: @escaping (Info) -> Void) {
        parsingResults = NetworkLayer()
        parsingResults?.getFilmInfo(for: id ?? Constants.nilId, complition: { [weak self] item in
            guard self != nil else { return }
            
            return complition(item)
        })
    }
    
    public func loadFilmTrailer(id: Int?, complition: @escaping (Trailers) -> Void) {
        parsingResults = NetworkLayer()
        parsingResults?.getTrailers(for: id ?? Constants.nilId, complition: { [weak self] item in
            guard self != nil else { return }
            
            return complition(item)
        })
    }
}
