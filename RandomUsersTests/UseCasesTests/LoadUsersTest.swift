//
//  LoadUsersTest.swift
//  RandomUsersTests
//
//  Created by Martin Lukacs on 04/03/2022.
//

import XCTest
@testable import RandomUsers

class LoadUsersTest: XCTestCase {
    var userRepo: MockUserRepository!
    var sut: LoadUsers!
        
    override func setUpWithError() throws {
        userRepo = MockUserRepository()
        sut = LoadUsers(userRepository: userRepo)
    }

    func test_userLoadingUseCase_shouldLoadNewUsersInRepo() throws {
        XCTAssertTrue(userRepo.users.value.isEmpty)
        sut.execute()
        XCTAssertEqual(userRepo.users.value.count, 1)
        sut.execute()
        XCTAssertEqual(userRepo.users.value.count, 2)
        sut.execute()
        XCTAssertEqual(userRepo.users.value.count, 3)
    }

}
