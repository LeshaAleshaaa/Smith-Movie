//
//  FilmListControllerTableExtension.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 30.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import UIKit

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
        
        if ValuesConstants.page < ValuesConstants.totalPages && indexPath.row == dataArray.count - ValuesConstants.firstScore {
            ValuesConstants.page += ValuesConstants.firstScore
            loadData(page: ValuesConstants.page, baseApi: URLList.basicApi)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filmInfoController = FilmInfoViewController()
        filmInfoController.id = dataArray[indexPath.row].id
        navigationController?.pushViewController(filmInfoController, animated: true)
    }
}
