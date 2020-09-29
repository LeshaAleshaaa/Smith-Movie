//
//  Moya.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 28.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import Moya

// MARK: - MoyaExampleService

enum MoyaExampleService {
    case getFilms(page: Int, baseApi: String)
    case getInfo(id: Int)
    case getTrailers(id: Int)
}

// MARK: - MoyaExampleService: TargetType

extension MoyaExampleService: TargetType {
    
    var baseURL: URL {
        switch self {
        case .getFilms(let page, let baseApi):
            guard let url =
                    URL(string: "\(baseApi)&page=\(page)")
            else { fatalError() }
            return url

        case .getInfo(let id):
            guard let url = URL(string: "\(URLList.urlFirstTitle)\(id)?api_key=\(URLList.apiKey)")
            else { fatalError() }
            return url
            
        case .getTrailers(let id):
            guard let url = URL(string: "\(URLList.urlFirstTitle)\(id)/videos?api_key=\(URLList.apiKey)")
            else { fatalError() }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .getFilms:
            return ""
        case .getInfo:
            return ""
        case .getTrailers:
            return ""
        }
    }
    
    var method: Method {
        .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
