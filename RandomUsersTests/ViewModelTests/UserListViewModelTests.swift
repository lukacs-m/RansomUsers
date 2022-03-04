//
//  UserListViewModelTests.swift
//  RandomUsersTests
//
//  Created by Martin Lukacs on 04/03/2022.
//


import XCTest
import Resolver
import Combine
@testable import RandomUsers

class UserListViewModelTests: XCTestCase {
    var sut: UserListViewModel!
    
    override func setUp() {
        Resolver.resetUnitTestRegistrations()
        Resolver.test.register{ MockUserUseCases() as UserUseCasesProviding }
    }
    
    override func tearDown() {
        Resolver.root = .main
    }

    func test_ViewModelState_shouldBeFInished() throws {
        sut = UserListViewModel()
        XCTAssertTrue(sut.state == .finished)
        XCTAssertTrue(sut.users.count == 0)
    }
    
    func test_ViewModelState_shouldloadusers() throws {
        sut = UserListViewModel()
        sut.loadUsers()
        XCTAssertTrue(sut.state == .loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(self.sut.users.count == 1)
        }
    }
}

