//
//  MainViewController.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 28.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - FilmListController

final class FilmListController: UIViewController {
       
    // MARK: - Public properties
    
    lazy var dataArray = [Info]()

    // MARK: - Private properties
    
    private lazy var tableView = UITableView()
    private lazy var reachability: IReachability = Reachability()
    private lazy var results = Results()
    private var parsingResults: INetworkLayer?
    private lazy var parsing = FilmInfoParsing()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addViews()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        checkInternet()
    }
    
    // MARK: - Public methods
    
    public func loadData(page: Int, baseApi: String) {
        parsingResults = NetworkLayer()
        parsingResults?.getFilms(page: page, baseApi: baseApi, complition: { [weak self] item in
            guard let self = self else { return }
            self.results = item
            DispatchQueue.main.async {
                Constants.totalPages = item.total_pages ?? Constants.firstScore
                if let someItem = item.results {
                    self.dataArray.append(contentsOf: someItem)
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    // MARK: - Private methods
    
    private func checkInternet() {
        if !reachability.isConnectedToNetwork {
            alert(title: Constants.alertTitle,
                  message: Constants.alertMesage)
        }
    }
}

// MARK: - Setups

private extension FilmListController {
    
    func setupViews() {
        setScreen()
        setTableView()
    }
    
    func setScreen() {
        title = Constants.titleText
        loadData(page: Constants.firstScore, baseApi: URLList.basicApi)
    }
    
    func setTableView() {
        tableView.register(FilmCell.self, forCellReuseIdentifier: Constants.cellName)
        tableView.rowHeight = view.bounds.height / Constants.viewBoundsDel
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Setup Elements

private extension FilmListController {
    
    func addViews() {
        view.addSubview(tableView)
    }
}

// MARK: - Layout

private extension FilmListController {
    
    func layout() {
        
        tableView.snp.makeConstraints { (tableView) in
            tableView.top.equalTo(view)
            tableView.left.equalTo(view)
            tableView.right.equalTo(view)
            tableView.bottom.equalTo(view)
        }
    }
}
