//
//  MockAPI.swift
//  RandomUsersTests
//
//  Created by Martin Lukacs on 04/03/2022.
//

import Foundation
import Combine
@testable import RandomUsers

struct MockAPI: DataFetching {
    func fetch<ReturnType: Decodable>(at endpointURL: URL) -> AnyPublisher<ReturnType, Error> {
        let users = Users(results: [MockFactory.createUser()], info: Info(seed: "", results: 1, page: 1, version: ""))
        return Just(users as! ReturnType)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
