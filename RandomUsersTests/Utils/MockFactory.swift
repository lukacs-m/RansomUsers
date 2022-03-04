//
//  MockFactory.swift
//  RandomUsersTests
//
//  Created by Martin Lukacs on 04/03/2022.
//

import Foundation
@testable import RandomUsers

enum MockFactory {
    static func createUser() -> User {
        let location = Location(street: Street(number: 4, name: ""),
                                city: "",
                                state: "",
                                country: "",
                                postcode: Postcode.string(""),
                                coordinates: Coordinates(latitude: "", longitude: ""),
                                timezone: Timezone(offset: "", timezoneDescription: ""))
        
        let login = Login(uuid: "",
                          username: "",
                          password: "",
                          salt: "",
                          md5: "",
                          sha1: "",
                          sha256: "")
        
       return User(gender: "genderTest",
             name: Name(title: "", first: "debby", last: "kelt"),
             location: location,
             email: "email@email.com",
             login: login,
             dob: Dob(date: "", age: 27),
             registered:  Dob(date: "", age: 27),
             phone: "",
             cell: "",
             id: ID(name: "", value: nil),
             picture: Picture(large: "", medium: "", thumbnail: ""),
             nat: "")
    }
}
