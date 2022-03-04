//
//  UserUseCases.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 02/03/2022.
//

import Foundation
import Combine
import Resolver

protocol UserUseCasesProviding {
    var refreshUsers: UseCase { get }
    var loadUsers: UseCase { get }
    var filterUsers: FilterUsersUseCase { get }
    var usersCurrentState: UsersCurrentStateUseCase { get }
}

protocol UseCases {}

final class UserUseCases: UserUseCasesProviding {
    @Injected(name: .refreshUser) var refreshUsers: UseCase
    @Injected(name: .loadUsers) var loadUsers: UseCase
    @Injected var filterUsers: FilterUsersUseCase
    @Injected var usersCurrentState: UsersCurrentStateUseCase
}




