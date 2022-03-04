//
//  API.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//

import Foundation
import Combine

protocol DataFetching {
    func fetch<ReturnType: Decodable>(at endpointURL: URL) -> AnyPublisher<ReturnType, Error>
}

struct API: DataFetching {
    var session = URLSession.shared
    var decoder = JSONDecoder()

    func fetch<ReturnType: Decodable>(at endpointURL: URL) -> AnyPublisher<ReturnType, Error> {
        session
            .dataTaskPublisher(for: endpointURL)
            .map(\.data)
            .decode(type: ReturnType.self,
                    decoder: decoder)
            .eraseToAnyPublisher()
    }
}
