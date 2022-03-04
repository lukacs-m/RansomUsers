//
//  Repositories+Dependencies.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//  
//

import Resolver

extension Resolver {

    public static func registerRepositories() {
        register { UserRepository() as UserFetching }.scope(.application)
    }
}

