//
//  UserListViewModel.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//

import Foundation
import Combine
import Resolver

enum ListViewModelError: Error, Equatable {
    case playersFetch
}

enum LoadingState: Equatable {
    case idle
    case loading
    case finished
    case searching
}
enum UserListViewModelSection { case users }

final class UserListViewModel {
    @Injected private var userUseCase: UserUseCasesProviding
    @Injected private var networkReachability: NetworkReachability
    @Published private(set) var users: [User] = []
    @Published private(set) var state: LoadingState = LoadingState.idle
    private var currentSearchQuery: String = ""
    
    private var bindings = Set<AnyCancellable>()
    
    init() {
        setUpData()
    }

    func loadUsers() {
        state = .loading
        userUseCase.loadUsers.execute()
    }
    
    func refreshUsers() {
        state = .loading
        userUseCase.refreshUsers.execute()
    }
    
    func search(query: String? = nil) {
        if let query = query, !query.isEmpty {
            state = .searching
            users = userUseCase.filterUsers.execute(with: query)
        } else {
            state = .finished
            users = userUseCase.usersCurrentState.execute().value
        }
    }
    
    func canPullMoreUsers() -> Bool {
        state != .loading
        && state != .searching
        && networkReachability.isNetworkAvailable.value
    }
}

private extension UserListViewModel {
    func setUpData() {
        userUseCase.usersCurrentState.execute()
            .sink { [weak self] users in
                self?.state = .finished
                self?.users = users
            }
            .store(in: &bindings)
    }
}
