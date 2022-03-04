//
//  MockUserRepository.swift
//  RandomUsersTests
//
//  Created by Martin Lukacs on 04/03/2022.
//

import Foundation
import Combine
@testable import RandomUsers

class MockUserRepository: UserFetching {
    var users: CurrentValueSubject<[User], Never> = .init([])
    
    func loadUsers(shouldFresh: Bool) {
        guard !shouldFresh else {
            users.send([MockFactory.createUser()])
            return
        }
        var currentUsers = users.value
        currentUsers.append(MockFactory.createUser())
        users.send(currentUsers)
    }
}
