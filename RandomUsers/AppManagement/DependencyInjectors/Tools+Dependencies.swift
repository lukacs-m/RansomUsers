//
//  Tools+Dependencies.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//  
//

import Resolver

extension Resolver.Name {
    static let refreshUser = Self("RefreshUser")
    static let loadUsers = Self("LoadUsers")
}

extension Resolver {

    public static func registerTools() {
        register { API() as DataFetching }.scope(.application)
        register { ReachabilityService() as NetworkReachability }.scope(.application)
        register { UserRemoteService() as UserDataSource }.scope(.shared)
        register { UserLocalService() as UserLocalDataSource }.scope(.shared)
        register(name: .refreshUser) { RefreshUsers(userRepository: Resolver.resolve()) as UseCase }.scope(.shared)
        register(name: .loadUsers) { LoadUsers(userRepository: Resolver.resolve()) as UseCase }.scope(.shared)
        register { FilterUsers(userRepository: Resolver.resolve()) as FilterUsersUseCase }.scope(.shared)
        register { UsersCurrentState(userRepository: Resolver.resolve()) as UsersCurrentStateUseCase}.scope(.shared)
        register { UserUseCases() as UserUseCasesProviding }.scope(.shared)
    }
}
