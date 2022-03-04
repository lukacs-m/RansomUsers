//
//  LoadUsers.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 02/03/2022.
//

final class LoadUsers: UseCase {
    private let userRepository: UserFetching
    
    init(userRepository: UserFetching) {
        self.userRepository = userRepository
    }
    
    func execute() {
        userRepository.loadUsers(shouldFresh: false)
    }
}
