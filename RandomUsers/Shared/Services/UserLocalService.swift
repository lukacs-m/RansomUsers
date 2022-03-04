//
//  UserLocalService.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 03/03/2022.
//

import Foundation
import Combine

protocol UserLocalDataSource {
    func getUsers() -> AnyPublisher<[User], Never>
    func updateCacheData(with users: [User])
}

// MARK: - Networking call within this class will happen
struct UserLocalService: UserLocalDataSource {
    private var cache = Cache<String, [User]>()
    private let dataKey = "Users"
    private let decoder = JSONDecoder()
    
    init() {
        if let persistedCache = Cache<String, [User]>.getSavedCache(withName: CacheConfig.userPersistanceKey) {
            cache = try! decoder.decode(Cache<String, [User]>.self, from: persistedCache)
        }
    }
    
    func getUsers() -> AnyPublisher<[User], Never> {
        Just(cache[dataKey] ?? []).eraseToAnyPublisher()
    }
    
    func updateCacheData(with users: [User]) {
        cache[dataKey] = users
        try? cache.saveToDisk(withName: CacheConfig.userPersistanceKey)
    }
}
