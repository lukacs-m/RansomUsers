//
//  Routing+Dependencies.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//  
//

import Resolver

extension Resolver {

    public static func registerRouting() {
        register { MainCoordinator() as AppNavigationFlow }.scope(.application)
    }
}


