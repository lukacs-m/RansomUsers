//
//  RefreshUsersTests.swift
//  RandomUsersTests
//
//  Created by Martin Lukacs on 04/03/2022.
//

import XCTest
@testable import RandomUsers

class RefreshUsersTest: XCTestCase {
    var userRepo: MockUserRepository!
    var sut: RefreshUsers!
        
    override func setUpWithError() throws {
        userRepo = MockUserRepository()
        sut = RefreshUsers(userRepository: userRepo)
    }

    func test_refreshUsersUseCase_shouldRefreshUsersInRepo() throws {
        XCTAssertTrue(userRepo.users.value.isEmpty)
        sut.execute()
        XCTAssertEqual(userRepo.users.value.count, 1)
        sut.execute()
        XCTAssertEqual(userRepo.users.value.count, 1)
        sut.execute()
        XCTAssertEqual(userRepo.users.value.count, 1)
    }
}
