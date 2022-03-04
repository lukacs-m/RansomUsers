//
//  UserRepositoryTests.swift
//  RandomUsersTests
//
//  Created by Martin Lukacs on 04/03/2022.
//

import XCTest
import Resolver
import Combine
@testable import RandomUsers

class UserRepositoryTests: XCTestCase {

    override func setUp() {
        Resolver.resetUnitTestRegistrations()
    }
    
    override func tearDown() {
        Resolver.root = .main
    }

    func test_userRepository_shouldFetchUserData() throws {
        Resolver.test.register { MockAPI() as DataFetching }

        let sut = UserRepository()
        XCTAssertTrue(sut.users.value.isEmpty)
        sut.loadUsers(shouldFresh: false)
        XCTAssertEqual(sut.users.value.count, 1)
        sut.loadUsers(shouldFresh: false)
        XCTAssertEqual(sut.users.value.count, 2)
        sut.loadUsers(shouldFresh: true)
        XCTAssertEqual(sut.users.value.count, 1)
    }

}

