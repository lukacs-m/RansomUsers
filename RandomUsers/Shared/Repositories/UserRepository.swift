//
//  UserRepository.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//

import Foundation
import Combine
import Resolver

protocol UserFetching {
    var users: CurrentValueSubject<[User], Never> { get }
    func loadUsers(shouldFresh: Bool)
}

final class UserRepository {
    @Injected private var remoteDateSource: UserDataSource
    @Injected private var localDataSource: UserLocalDataSource
    
    var users: CurrentValueSubject<[User], Never> = .init([])
    private var cancellable = Set<AnyCancellable>()
}

extension UserRepository: UserFetching {
    func loadUsers(shouldFresh: Bool) {
        remoteDateSource.getUsers()
            .map { $0.results }
            .catch { [weak self] _ in
                self?.localDataSource.getUsers() ?? Just([]).eraseToAnyPublisher()
            }
            .sink { [weak self] result in
                guard let self = self else {
                    return
                }
                var newUsers = shouldFresh ? result : self.users.value
                if !shouldFresh  {
                    newUsers.append(contentsOf: result)
                }
                self.localDataSource.updateCacheData(with: newUsers)
                self.users.send(newUsers)
            }.store(in: &cancellable)
    }
}
