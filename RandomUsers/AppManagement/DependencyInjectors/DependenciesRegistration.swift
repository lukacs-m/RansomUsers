//
//  DependenciesRegistration.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//  
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerTools()
        registerRepositories()
        registerRouting()
        registerViewModels()
    }
}
