//
//  FilterUsersTests.swift
//  RandomUsersTests
//
//  Created by Martin Lukacs on 04/03/2022.
//

import XCTest
@testable import RandomUsers

class FilterUsersTests: XCTestCase {
    var userRepo: MockUserRepository!
    var sut: FilterUsers!
        
    override func setUpWithError() throws {
        userRepo = MockUserRepository()
        for _ in 0...4 {
            userRepo.loadUsers(shouldFresh: false)
        }
        sut = FilterUsers(userRepository: userRepo)
    }

    func test_filterUserssUseCase_shouldRefreshUsersInRepo() throws {
        let filter1 = sut.execute(with: "plop")
        let filter2 = sut.execute(with: "debby")
        XCTAssertEqual(filter1.count, 0)
        XCTAssertEqual(filter2.count, 5)
    }
}

