//
//  FilmInfoViewController.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 29.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import UIKit
import WebKit

// MARK: - FilmInfoViewController

final class FilmInfoViewController: UIViewController {
       
    // MARK: - Public properties
    
    var id: Int?
    
    // MARK: - Private properties
    
    private lazy var filmParsing = FilmInfoParsing()

    // MARK: - Life Cycle
    
    override func loadView() {
       self.view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        filmParsing.loadFilmInfoData(id: id)
        filmParsing.loadFilmTrailer(id: id)
    }
        
    // MARK: - Selectors
    
    @objc
    private func shareFilm() {
        let URLString = "\(URLList.urlFirstTitle)\(filmParsing.idForm ?? Constants.nilId)"
        let items = ["\(Constants.lookFilm) \(Constants.nilText)\(Constants.shareFilmText)\(URLString)"]
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
}
