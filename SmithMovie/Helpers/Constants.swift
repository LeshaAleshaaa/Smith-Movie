//
//  FilmInfoView.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 30.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import UIKit

enum Constants {
    
    static let filmNameFont = UIFont(name: "AppleSDGothicNeo-Thin", size: 20.0)
    
    static let filmImageHeight: CGFloat = 300
    static let overviewHeight: CGFloat = 200
    static let overviewFont = UIFont(name: "AppleSDGothicNeo-Thin", size: 20.0)
    
    static let popularityImageTop: CGFloat = 20
    static let popularityImageLeading: CGFloat = 10
    static let popularityImageWidth: CGFloat = 30
    static let popularityImageHeight: CGFloat = 30
    static let popularityImageImage = UIImage(named: "popularity")
    
    static let popularityLabelLeading: CGFloat = 10
    static let popularityLabelFont = UIFont(name: "AppleSDGothicNeo-Thin", size: 13.0)
    
    static let releaseImageTrailing: CGFloat = -10
    static let releaseImageTop: CGFloat = 20
    static let releaseImageWidth: CGFloat = 30
    static let releaseImageHeight: CGFloat = 30
    static let releaseImageImage = UIImage(named: "calendar")
    
    static let releaseDateTrailing: CGFloat = -10
    static let releaseDateFont = UIFont(name: "AppleSDGothicNeo-Thin", size: 13.0)
    
    static let nilText: String = ""
    static let nilId: Int = 0
    static let nilDouble: Double = 0
    static let lookFilm: String = "Посмотри фильм: "
    static let shareFilmText: String = ", ссылка: "
}
