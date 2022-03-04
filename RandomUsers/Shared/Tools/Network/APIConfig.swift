//
//  APIConfig.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//

import Foundation

enum APIConfig {
    static var baseURL = "https://randomuser.me/api/"
    
    enum Endpoint {
        case users

        var url: URL {
            switch self {
            case .users:
                return URL(string: "\(APIConfig.baseURL)?results=10")!
            }
        }
    }
}
