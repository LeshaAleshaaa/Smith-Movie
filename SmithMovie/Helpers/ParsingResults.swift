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
    
    // MARK: - Public properties
    
    public var idForm: Int?
    
    // MARK: - Private properties
    
    private lazy var information = Info()
    private lazy var trailers = Trailers()
    private var parsingResults: INetworkLayer?
    private lazy var filmInfoView = CustomView()
    private var trailerKey: String?
    
    // MARK: - Private methods
    
    public func loadFilmInfoData(id: Int?) {
        parsingResults = NetworkLayer()
        parsingResults?.getFilmInfo(for: id ?? Constants.nilId, complition: { [weak self] item in
            guard let self = self else { return }
            
            self.information = item
            DispatchQueue.main.async {
                self.filmInfoView.setup(title: self.information.title ?? "", name: self.information.overview ?? "", popularity: self.information.popularity ?? 0, release: self.information.release_date ?? "")
            }
        })
    }
    
    public func loadFilmTrailer(id: Int?) {
        parsingResults = NetworkLayer()
        parsingResults?.getTrailers(for: id ?? Constants.nilId, complition: { [weak self] item in
            guard let self = self else { return }
            
            self.trailers = item
            DispatchQueue.main.async {
                self.trailerKey = item.results?.first?.key
                guard
                    let url = URL(string: "\(URLList.urlTrailer)\(self.trailerKey ?? Constants.nilText)")
                else { return }
                self.filmInfoView.trailerView.load(URLRequest(url: url))
                self.filmInfoView.trailerView.allowsBackForwardNavigationGestures = true
            }
        })
    }
}
