//
//  FilmInfoViewController.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 29.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import UIKit

// MARK: - FilmInfoViewController

final class FilmInfoViewController: UIViewController {
    
    // MARK: - Public properties
    
    public var id: Int?
    
    // MARK: - Private properties
    
    private lazy var filmParsing = FilmInfoParsing()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = FilmInfoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupElements()
    }
    
    // MARK: - Selectors
    
    @objc
    private func shareFilm() {
        let URLString = "\(URLList.urlFirstTitle)\(id ?? Constants.nilId)"
        let items = ["\(Constants.lookFilm)\(Constants.shareFilmText)\(URLString)"]
        let activity = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activity, animated: true, completion: nil)
    }
}

// MARK: - Setups

private extension FilmInfoViewController {
    
    func setupViews() {
        setNaviBar()
    }
    
    func setNaviBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareFilm))
    }
    
    func setupElements() {
        filmParsing.loadFilmTrailer(id: id) { item in
            DispatchQueue.main.async {
                (self.view as? FilmInfoView)?.setupTrailerView(
                    trailerKey: item.results?.first?.key ?? Constants.emptyString)
            }
        }
        
        filmParsing.loadFilmInfoData(id: id) { item in
            DispatchQueue.main.async {
                (self.view as? FilmInfoView)?.setupViews(title: item.title!, name: item.overview!)
            }
        }
    }
}
