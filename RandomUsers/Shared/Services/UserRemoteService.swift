//
//  UserRemoteService.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//

import Foundation
import Combine
import Resolver

protocol UserDataSource {
    func getUsers() -> AnyPublisher<Users, Error>
}

// MARK: - Networking call within this class will happen
struct UserRemoteService: UserDataSource {
    @Injected var api: DataFetching
    
    func getUsers() -> AnyPublisher<Users, Error> {
        api.fetch(at: APIConfig.Endpoint.users.url)
    }
}
