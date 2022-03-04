//
//  UsersCurrentState.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 02/03/2022.
//

import Combine

protocol UsersCurrentStateUseCase {
    func execute() -> CurrentValueSubject<[User], Never>
}

final class UsersCurrentState: UsersCurrentStateUseCase {
    private let userRepository: UserFetching
    
    init(userRepository: UserFetching) {
        self.userRepository = userRepository
    }
    
    func execute() -> CurrentValueSubject<[User], Never> {
        userRepository.users
    }
}
