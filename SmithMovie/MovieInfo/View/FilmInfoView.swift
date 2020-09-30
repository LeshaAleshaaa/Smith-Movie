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

// MARK: - CustomView

final class FilmInfoView: UIView {
    
    // MARK: - Private properties
    
    private lazy var filmInfoView = UIView()
    private lazy var filmScrollView = UIScrollView()
    private lazy var filmName = UILabel()
    private lazy var filmOverview = UILabel()
    private lazy var trailerView = WKWebView()
    private var trailerKey: String?
    
    // MARK: - Public methods
    
    public func setupViews(title: String, name: String) {
        self.filmName.text = title
        self.filmOverview.text = name
    }
    
    public func setupTrailerView(trailerKey: String) {
        self.trailerKey = trailerKey
        guard let url = URL(string: "\(URLList.urlTrailer)\(self.trailerKey ?? Constants.nilText)")
        else { return }
        self.trailerView.load(URLRequest(url: url))
        self.trailerView.allowsBackForwardNavigationGestures = true
    }
    
    // MARK: - Initalization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.errorKey)
    }
    
    // MARK: - SetupViews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        filmScrollView.snp.makeConstraints { (filmScrollView) in
            filmScrollView.top.equalTo(safeAreaLayoutGuide.snp.top)
            filmScrollView.left.equalTo(snp.left)
            filmScrollView.right.equalTo(snp.right)
            filmScrollView.bottom.equalTo(snp.bottom)
        }
        
        filmName.snp.makeConstraints { (filmName) in
            filmName.top.equalTo(filmScrollView.snp.top)
            filmName.left.equalTo(filmScrollView.snp.left)
            filmName.right.equalTo(filmScrollView.snp.right)
            filmName.centerX.equalTo(filmScrollView.snp.centerX)
        }
        
        trailerView.snp.makeConstraints { (trailerView) in
            trailerView.top.equalTo(filmName.snp.bottom)
            trailerView.centerX.equalTo(filmScrollView.snp.centerX)
            trailerView.left.equalTo(filmScrollView.snp.left)
            trailerView.right.equalTo(filmScrollView.snp.right)
            trailerView.height.equalTo(Constants.trailerViewHeight)
        }
        
        filmOverview.snp.makeConstraints { (filmOverview) in
            filmOverview.top.equalTo(trailerView.snp.bottom).offset(Constants.filmOverviewTop)
            filmOverview.centerX.equalTo(filmScrollView.snp.centerX)
            filmOverview.left.equalTo(filmScrollView.snp.left)
            filmOverview.right.equalTo(filmScrollView.snp.right)
            filmOverview.bottom.equalTo(filmScrollView.snp.bottom)
        }
    }
}

// MARK: - Setups

private extension FilmInfoView {
    
    func setupViews() {
        filmName.textAlignment = .center
        filmName.font = Fonts.filmNameFont
        filmOverview.font = Fonts.overviewFont
        filmOverview.textAlignment = .center
        filmOverview.numberOfLines = .bitWidth
        filmOverview.lineBreakMode = .byTruncatingTail
        filmScrollView.isUserInteractionEnabled = true
        filmScrollView.contentSize = CGSize(width: bounds.width, height: bounds.height * Constants.contentHeight)
    }
}

// MARK: - Setup Elements

private extension FilmInfoView {
    
    func addViews() {
        addSubview(filmScrollView)
        filmScrollView.addSubview(filmName)
        filmScrollView.addSubview(trailerView)
        filmScrollView.addSubview(filmOverview)
    }
}
