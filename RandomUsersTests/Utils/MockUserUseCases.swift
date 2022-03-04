//
//  MockUserUseCases.swift
//  RandomUsersTests
//
//  Created by Martin Lukacs on 04/03/2022.
//

import Foundation
@testable import RandomUsers

final class MockUserUseCases: UserUseCasesProviding {
    let refreshUsers: UseCase = RefreshUsers(userRepository: MockUserRepository())
    let loadUsers: UseCase = LoadUsers(userRepository: MockUserRepository())
    @Injected var filterUsers: FilterUsersUseCase
    @Injected var usersCurrentState: UsersCurrentStateUseCase
}
