//
//  FilmInfoView.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 30.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import UIKit

// MARK: - SmithMovie Constants

enum Constants {
    
    // MARK: - LocalizedStrings
    
    static let lookFilmKey = NSLocalizedString("LookFilm", comment: "")
    static let shareKey = NSLocalizedString("Share", comment: "")
    static let errorKey = NSLocalizedString("Error", comment: "")
    static let warningKey = NSLocalizedString("Warning", comment: "")
    static let internetLost = NSLocalizedString("InternetLost", comment: "")
    static let titleTextLocalize = NSLocalizedString("Title", comment: "")
    static let cellNameLocalize = NSLocalizedString("Cell", comment: "")
    
    // MARK: - FilmInfo Constants
    
    static let trailerViewHeight: CGFloat = 400
    
    static let nilText: String = ""
    static let nilId: Int = 0
    static let nilDouble: Double = 0
    
    static let lookFilm: String = lookFilmKey
    static let shareFilmText: String = shareKey
    static let filmOverviewTop: CGFloat = 50
    static let contentHeight: CGFloat = 2
    
    // MARK: - FilmList Constants
    
    static let alertMesage: String = internetLost
    static let alertTitle: String = warningKey
    static let titleText: String = titleTextLocalize
    static let cellName: String = cellNameLocalize
    
    static var page: Int = 1
    static var totalPages: Int = 1
    static let firstScore: Int = 1
    static let viewBoundsDel: CGFloat = 2.5
    static let filmTitleHeight: CGFloat = 30
    
    // MARK: - FilmListCell Constants
    
    static let errorText: String = errorKey
    
    static let ratingWidth: CGFloat = 50
    static let ratighHeight: CGFloat = 50
    
    static let ratingCenterY: CGFloat = 4
    
    static let emptyString: String = ""
    static let emptyDouble: Double = 0
    
    static let viewsOffsets: CGFloat = 10
    static let viewsMinusOffsets: CGFloat = -10
    
    static let imageWidth: CGFloat = 200
    static let filmOverViewLines: Int = 5
    static let filmOverViewOffset: CGFloat = 40
}
