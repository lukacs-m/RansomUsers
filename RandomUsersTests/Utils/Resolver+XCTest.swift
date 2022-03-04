//
//  Resolver+XCTest.swift
//  RandomUsersTests
//
//  Created by Martin Lukacs on 04/03/2022.
//

import XCTest
import Resolver

@testable import RandomUsers

extension Resolver {
    
    static var test: Resolver!
    
    static func resetUnitTestRegistrations() {
        Resolver.test = Resolver(child: .main)
        Resolver.root = Resolver.test
        Resolver.test.register { MockUserRepository() as UserFetching }
    }
}
