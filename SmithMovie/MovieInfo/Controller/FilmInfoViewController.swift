//
//  FilmInfoViewController.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 08.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import UIKit
import WebKit

// MARK: - FilmInfoViewController

final class FilmInfoViewController: UIViewController {
    
    // MARK: - Public methods
    
    public var idForm: Int?
    
    // MARK: - Private properties
    
    private lazy var filmName = UILabel()
    private lazy var filmOverview = UITextView()
    private lazy var releaseDate = UILabel()
    private lazy var popularityLabel = UILabel()
    private lazy var releaseImage = UIImageView()
    private lazy var popularityImage = UIImageView()
    private lazy var trailerView = WKWebView()
    private lazy var information = Info()
    private lazy var trailers = Trailers()
    private var parsingResults: INetworkLayer?
    private var trailerKey: String?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addViews()
        layout()
        loadData()
        loadTrailer()
    }
    
    // MARK: - Private methods
    
    private func loadData() {
        parsingResults = NetworkLayer()
        parsingResults?.getFilmInfo(for: idForm ?? Constants.nilId, complition: { [weak self] item in
            guard let self = self else { return }
            
            self.information = item
            DispatchQueue.main.async {
                self.filmName.text = self.information.title
                self.filmOverview.text = self.information.overview
                self.popularityLabel.text = "\(self.information.popularity ?? Constants.nilDouble)"
                self.releaseDate.text = self.information.release_date
            }
        })
    }
    
    private func loadTrailer() {
        parsingResults = NetworkLayer()
        parsingResults?.getTrailers(for: idForm ?? Constants.nilId, complition: { [weak self] item in
            guard let self = self else { return }
            
            self.trailers = item
            DispatchQueue.main.async {
                self.trailerKey = item.results?.first?.key
                guard
                    let url = URL(string: "\(URLList.urlTrailer)\(self.trailerKey ?? Constants.nilText)")
                else { return }
                self.trailerView.load(URLRequest(url: url))
                self.trailerView.allowsBackForwardNavigationGestures = true
            }
        })
    }
    
    // MARK: - Selectors
    
    @objc
    private func shareFilm() {
        let URLString = "\(URLList.urlFirstTitle)\(idForm ?? Constants.nilId)"
        let items = ["\(Constants.lookFilm)\(filmName.text ?? Constants.nilText)\(Constants.shareFilmText)\(URLString)"]
        let activity = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activity, animated: true, completion: nil)
    }
}

// MARK: - Setups

private extension FilmInfoViewController {
    
    func setupViews() {
        setNaviBar()
        setPopularityViews()
        setDateViews()
        setOverview()
    }
    
    func setNaviBar() {
        filmName.font = Constants.filmNameFont
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareFilm))
    }
    
    func setPopularityViews() {
        popularityLabel.font = Constants.popularityLabelFont
        popularityImage.image = Constants.popularityImageImage
    }
    
    func setDateViews() {
        releaseDate.font = Constants.releaseDateFont
        releaseImage.image = Constants.releaseImageImage
    }
    
    func setOverview() {
        filmOverview.font = Constants.overviewFont
        filmOverview.isEditable = false
    }
}

// MARK: - Setup Elements

private extension FilmInfoViewController {
    
    func addViews() {
        view.addSubview(filmName)
        view.addSubview(trailerView)
        view.addSubview(filmOverview)
        view.addSubview(popularityLabel)
        view.addSubview(popularityImage)
        view.addSubview(releaseDate)
        view.addSubview(releaseImage)
    }
}

// MARK: - Layout

private extension FilmInfoViewController {
    
    func layout() {
        
        filmName.snp.makeConstraints { (filmName) in
            filmName.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            filmName.centerX.equalTo(view.snp.centerX)
        }
        
        trailerView.snp.makeConstraints { (trailerView) in
            trailerView.top.equalTo(filmName.snp.bottom)
            trailerView.centerX.equalTo(view.snp.centerX)
            trailerView.left.equalTo(view.snp.left)
            trailerView.right.equalTo(view.snp.right)
            trailerView.height.equalTo(Constants.filmImageHeight)
        }
        
        filmOverview.snp.makeConstraints { (filmOverview) in
            filmOverview.top.equalTo(trailerView.snp.bottom)
            filmOverview.centerX.equalTo(view.snp.centerX)
            filmOverview.left.equalTo(view.snp.left)
            filmOverview.right.equalTo(view.snp.right)
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

// MARK: - Constants

private extension FilmInfoViewController {
    
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
}
