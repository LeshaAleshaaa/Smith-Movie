//
//  MainViewController.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 06.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - MainViewController

final class FilmListController: UIViewController {
        
    // MARK: - Private properties
    
    private lazy var tableView = UITableView()
    private lazy var dataArray = [Info]()
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
    
    // MARK: - Private methods
    
    private func checkInternet() {
        if !reachability.isConnectedToNetwork {
            alert(title: Constants.alertTitle,
                  message: Constants.alertMesage)
        }
    }
    
    private func loadData(page: Int, baseApi: String) {
        parsingResults = NetworkLayer()
        parsingResults?.getFilms(page: page, baseApi: baseApi, complition: { [weak self] item in
            guard let self = self else { return }
            self.results = item
            DispatchQueue.main.async {
                Constants.totalPages = item.total_pages ?? Constants.firstScore
                self.dataArray.append(contentsOf: item.results!)
                self.tableView.reloadData()
            }
        })
    }
}

// MARK: - Setups

extension FilmListController: UITableViewDelegate { }

extension FilmListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = FilmCell()
        
        cell.cellData = dataArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if Constants.page < Constants.totalPages && indexPath.row == dataArray.count - Constants.firstScore {
            Constants.page += Constants.firstScore
            loadData(page: Constants.page, baseApi: URLList.basicApi)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filmInfoController = FilmInfoViewController()
        filmInfoController.idForm = dataArray[indexPath.row].id
        navigationController?.pushViewController(filmInfoController, animated: true)
    }
}

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

// MARK: - Constants

private extension FilmListController {
    
    enum Constants {
        
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
