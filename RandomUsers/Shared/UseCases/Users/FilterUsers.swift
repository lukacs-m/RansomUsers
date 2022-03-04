//
//  FilterUsers.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 02/03/2022.
//

protocol FilterUsersUseCase {
    func execute(with query: String) -> [User]
}

final class FilterUsers: FilterUsersUseCase {
    private let userRepository: UserFetching
    
    init(userRepository: UserFetching) {
        self.userRepository = userRepository
    }
    
    func execute(with query: String) -> [User] {
        userRepository.users.value.filter { $0.name.fullName.lowercased().contains(query.lowercased()) }
    }
}
