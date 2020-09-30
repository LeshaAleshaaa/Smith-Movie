//
//  CustomData.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 28.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - FilmCell

final class FilmCell: UITableViewCell {
    
    // MARK: - Public properties
    
    public var cellData: Info? {
        didSet {
            guard
                let data = cellData,
                let imageURL = URL(string:"\(URLList.imageURL)\(data.poster_path ?? Constants.emptyString)")
            else { return }
            filmTitle.text = data.title
            filmImage.kf.setImage(with: imageURL)
            filmRating.text = "\(data.vote_average ?? Constants.emptyDouble)"
            filmOverview.text = data.overview
        }
    }
    
    // MARK: - Private properties
    
    private lazy var cellView = UIView()
    private lazy var filmTitle = UILabel()
    private lazy var filmRating = UILabel()
    private lazy var filmImage = UIImageView()
    private lazy var ratingImage = UIImageView()
    private lazy var filmOverview = UILabel()
    
    // MARK: - Initalization
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        setupViews()
        addViews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.errorText)
    }
}

// MARK: - Setups

private extension FilmCell {
    
    func setupViews() {
        setRatingView()
        setFilmTitle()
        setFilmOverview()
    }
    
    func setRatingView() {
        ratingImage.image = Constants.ratingImage
        filmRating.font = Constants.ratingFont
    }
    
    func setFilmTitle() {
        filmTitle.backgroundColor = .systemYellow
        filmTitle.textAlignment = .center
        filmTitle.font = Constants.filmTitleFont
    }
    
    func setFilmOverview() {
        filmOverview.font = Constants.filmOverviewFont
        filmOverview.backgroundColor = .systemGray5
        filmOverview.numberOfLines = .bitWidth
        filmOverview.lineBreakMode = .byTruncatingTail
    }
}

// MARK: - Setup Elements

private extension FilmCell {
    
    func addViews() {
        
        addSubview(cellView)
        cellView.addSubview(filmImage)
        cellView.addSubview(ratingImage)
        cellView.addSubview(filmRating)
        cellView.addSubview(filmTitle)
        cellView.addSubview(filmOverview)
    }
}

// MARK: - Layout

private extension FilmCell {
    
    func layout() {
        
        cellView.snp.makeConstraints { (cellView) in
            cellView.top.equalTo(snp.top)
            cellView.left.equalTo(snp.left)
            cellView.right.equalTo(snp.right)
            cellView.bottom.equalTo(snp.bottom)
        }
        
        filmImage.snp.makeConstraints { (filmImage) in
            filmImage.top.equalTo(cellView.snp.top).offset(Constants.viewsOffsets)
            filmImage.left.equalTo(cellView.snp.left).offset(Constants.viewsOffsets)
            filmImage.right.equalTo(cellView.snp.centerX)
            filmImage.bottom.equalTo(cellView.snp.bottom).offset(Constants.viewsMinusOffsets)
        }
        
        filmTitle.snp.makeConstraints { (filmTitle) in
            filmTitle.top.equalTo(cellView.snp.top).offset(Constants.viewsOffsets)
            filmTitle.left.equalTo(filmImage.snp.right).offset(Constants.viewsOffsets)
            filmTitle.right.equalTo(cellView.snp.right).offset(Constants.viewsMinusOffsets)
            filmTitle.height.equalTo(30)
        }
        
        filmOverview.snp.makeConstraints { (filmOverview) in
            filmOverview.top.equalTo(filmTitle.snp.bottom).offset(Constants.viewsOffsets)
            filmOverview.left.equalTo(filmImage.snp.right).offset(Constants.viewsOffsets)
            filmOverview.right.equalTo(cellView.snp.right).offset(Constants.viewsMinusOffsets)
            filmOverview.bottom.equalTo(filmImage.snp.bottom)
        }
        
        ratingImage.snp.makeConstraints { (ratingImage) in
            ratingImage.top.equalTo(filmImage.snp.top)
            ratingImage.left.equalTo(filmImage.snp.left)
            ratingImage.width.equalTo(Constants.ratingWidth)
            ratingImage.height.equalTo(Constants.ratighHeight)
        }
        
        filmRating.snp.makeConstraints { (filmRating) in
            filmRating.centerY.equalTo(ratingImage.snp.centerY).offset(Constants.ratingCenterY)
            filmRating.centerX.equalTo(ratingImage.snp.centerX)
        }
    }
}

// MARK: - Constants

private extension FilmCell {
    
    enum Constants {
        
        static let errorText: String = "init(coder:) has not been implemented"
        
        static let ratingWidth: CGFloat = 50
        static let ratighHeight: CGFloat = 50
        
        static let ratingImage = UIImage(named: "rating")
        static let ratingFont = UIFont(name: "AppleSDGothicNeo-Thin", size: 10.0)
        static let ratingCenterY: CGFloat = 4
        
        static let emptyString: String = ""
        static let emptyDouble: Double = 0
        
        static let filmTitleFont = UIFont(name: "AppleSDGothicNeo-Thin", size: 18.0)
        static let filmOverviewFont = UIFont(name: "AppleSDGothicNeo-Thin", size: 16.0)
        
        static let viewsOffsets: CGFloat = 10
        static let viewsMinusOffsets: CGFloat = -10
        
        static let imageWidth: CGFloat = 200
        static let filmOverViewLines: Int = 5
        static let filmOverViewOffset: CGFloat = 40
    }
}
