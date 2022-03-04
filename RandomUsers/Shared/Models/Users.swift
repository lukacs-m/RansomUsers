//
//  Users.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//

import Foundation

// MARK: - Users
struct Users: Codable, Hashable {
    let results: [User]
    let info: Info
}

// MARK: - Info
struct Info: Codable, Hashable {
    let seed: String
    let results, page: Int
    let version: String
}
