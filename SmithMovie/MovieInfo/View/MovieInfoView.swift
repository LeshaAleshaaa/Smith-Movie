//
//  File.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 30.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

final class CustomView: UIView {
    
    public var idForm: Int?

    public lazy var filmInfoView = UIView()
    public lazy var filmScrollView = UIScrollView()
    public lazy var filmName = UILabel()
    public lazy var filmOverview = UITextView()
    public lazy var releaseDate = UILabel()
    public lazy var popularityLabel = UILabel()
    public lazy var releaseImage = UIImageView()
    public lazy var popularityImage = UIImageView()
    public lazy var trailerView = WKWebView()
    public lazy var information = Info()
    public lazy var trailers = Trailers()
    public var parsingResults: INetworkLayer?
    public var trailerKey: String?
    
    
    // MARK: - Setup Properties
    
    func setup(title: String, name: String, popularity: Double, release: String) {
        DispatchQueue.main.async {
            self.filmName.text = title
            self.filmOverview.text = name
            self.popularityLabel.text = "\(popularity)"
            self.releaseDate.text = release
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
       super.layoutSubviews()
        
//        filmScrollView.snp.makeConstraints { (filmScrollView) in
//            filmScrollView.top.equalTo(snp.top)
//            filmScrollView.left.equalTo(snp.left)
//            filmScrollView.right.equalTo(snp.right)
//            filmScrollView.bottom.equalTo(snp.bottom)
//        }
        
        filmInfoView.snp.makeConstraints { (filmInfoView) in
            filmInfoView.top.equalTo(snp.top).offset(50)
            filmInfoView.left.equalTo(snp.left)
            filmInfoView.right.equalTo(snp.right)
            filmInfoView.bottom.equalTo(snp.bottom)
        }
        
        filmName.snp.makeConstraints { (filmName) in
            filmName.top.equalTo(filmInfoView.snp.top)
            filmName.left.equalTo(filmInfoView.snp.left)
            filmName.centerX.equalTo(filmInfoView.snp.centerX)
        }
        
        trailerView.snp.makeConstraints { (trailerView) in
            trailerView.top.equalTo(filmName.snp.bottom)
            trailerView.centerX.equalTo(filmInfoView.snp.centerX)
            trailerView.left.equalTo(filmInfoView.snp.left)
            trailerView.right.equalTo(filmInfoView.snp.right)
            trailerView.height.equalTo(Constants.filmImageHeight)
        }
        
        filmOverview.snp.makeConstraints { (filmOverview) in
            filmOverview.top.equalTo(trailerView.snp.bottom)
            filmOverview.centerX.equalTo(filmInfoView.snp.centerX)
            filmOverview.left.equalTo(filmInfoView.snp.left)
            filmOverview.right.equalTo(filmInfoView.snp.right)
            filmOverview.height.equalTo(Constants.overviewHeight)
        }
        
        popularityImage.snp.makeConstraints { (popularityImage) in
            popularityImage.top.equalTo(filmOverview.snp.bottom).offset(Constants.popularityImageTop)
            popularityImage.left.equalTo(filmOverview.snp.left).offset(Constants.popularityImageLeading)
            popularityImage.width.equalTo(Constants.popularityImageWidth)
            popularityImage.height.equalTo(Constants.popularityImageHeight)
        }
        
        popularityLabel.snp.makeConstraints { (popularityLabel) in
            popularityLabel.left.equalTo(popularityImage.snp.right).offset(Constants.popularityLabelLeading)
            popularityLabel.centerY.equalTo(popularityImage.snp.centerY)
        }
        
        releaseImage.snp.makeConstraints { (releaseImage) in
            releaseImage.right.equalTo(releaseDate.snp.left).offset(Constants.releaseImageTrailing)
            releaseImage.top.equalTo(filmOverview.snp.bottom).offset(Constants.releaseImageTop)
            releaseImage.width.equalTo(Constants.releaseImageWidth)
            releaseImage.height.equalTo(Constants.releaseImageHeight)
        }
        
        releaseDate.snp.makeConstraints { (releaseDate) in
            releaseDate.centerY.equalTo(releaseImage.snp.centerY)
            releaseDate.right.equalTo(filmOverview.snp.right).offset(Constants.releaseDateTrailing)
        }
    }
}

// MARK: - Setups

private extension CustomView {
    
    func setupViews() {
        filmName.backgroundColor = .yellow
        popularityLabel.font = Constants.popularityLabelFont
        popularityImage.image = Constants.popularityImageImage
        releaseDate.font = Constants.releaseDateFont
        releaseImage.image = Constants.releaseImageImage
        filmOverview.font = Constants.overviewFont
        filmOverview.isEditable = false
    }
}

// MARK: - Setup Elements

private extension CustomView {
    
    func addViews() {
        addSubview(filmInfoView)
        filmInfoView.addSubview(filmName)
        filmInfoView.addSubview(trailerView)
        filmInfoView.addSubview(filmOverview)
        filmInfoView.addSubview(popularityLabel)
        filmInfoView.addSubview(popularityImage)
        filmInfoView.addSubview(releaseDate)
        filmInfoView.addSubview(releaseImage)
    }
}
