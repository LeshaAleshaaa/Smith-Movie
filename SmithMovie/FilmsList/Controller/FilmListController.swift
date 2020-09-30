//
//  MainViewController.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 28.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - MainViewController

final class FilmListController: UIViewController {
       
    // MARK: - Public properties
    
    lazy var dataArray = [Info]()

    // MARK: - Private properties
    
    private lazy var tableView = UITableView()
    private lazy var reachability: IReachability = Reachability()
    private lazy var results = Results()
    private var parsingResults: INetworkLayer?
    
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
    
    func loadData(page: Int, baseApi: String) {
        parsingResults = NetworkLayer()
        parsingResults?.getFilms(page: page, baseApi: baseApi, complition: { [weak self] item in
            guard let self = self else { return }
            self.results = item
            DispatchQueue.main.async {
                ValuesConstants.totalPages = item.total_pages ?? ValuesConstants.firstScore
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
            alert(title: ValuesConstants.alertTitle,
                  message: ValuesConstants.alertMesage)
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
        title = ValuesConstants.titleText
        loadData(page: ValuesConstants.firstScore, baseApi: URLList.basicApi)
    }
    
    func setTableView() {
        tableView.register(FilmCell.self, forCellReuseIdentifier: ValuesConstants.cellName)
        tableView.rowHeight = view.bounds.height / ValuesConstants.viewBoundsDel
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

// MARK: - Constants

private extension FilmListController {
    
    enum Consants {
        
        static let cellName: String = "cell"
        
        static let titleText: String = "Smith Movie App"
        static let naviBarColor: UIColor = .black
        
        static let alertTitle: String = "Внимание"
        static let alertMesage: String =
            "Отсутствует связь с интернетом, проверьте соединение и перезапустите приложение!"
        
        static var page: Int = 1
        static var totalPages: Int = 1
        static let firstScore: Int = 1
        
        static let viewBoundsDel: CGFloat = 2.5
    }
}
