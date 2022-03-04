//
//  User.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//

import Foundation
import MapKit

// MARK: - User
struct User: Codable, Hashable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob, registered: Dob
    let phone, cell: String
    let id: ID
    let picture: Picture
    let nat: String
}

// MARK: - Name
struct Name: Codable, Hashable {
    let title, first, last: String
    
    var fullName: String {
        "\(first) \(last)"
    }
}

// MARK: - Dob
struct Dob: Codable, Hashable {
    let date: String
    let age: Int
}

// MARK: - ID
struct ID: Codable, Hashable {
    let name: String
    let value: String?
}

// MARK: - Picture
struct Picture: Codable, Hashable {
    let large, medium, thumbnail: String
}

// MARK: - Location
struct Location: Codable, Hashable {
    let street: Street
    let city, state, country: String
    let postcode: Postcode
    let coordinates: Coordinates
    let timezone: Timezone
}

// MARK: - Coordinates
struct Coordinates: Codable, Hashable {
    let latitude, longitude: String
    
    var latitudeDouble: Double {
        Double(latitude) ?? 0
    }
    
    var longitudeDouble: Double {
        Double(longitude) ?? 0
    }
    
    var position: CLLocation {
        return CLLocation(latitude:latitudeDouble, longitude: longitudeDouble)
    }
}

// MARK: - Street
struct Street: Codable, Hashable {
    let number: Int
    let name: String
}

// MARK: - Timezone
struct Timezone: Codable, Hashable {
    let offset, timezoneDescription: String

    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}

// MARK: - Login
struct Login: Codable, Hashable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}

enum Postcode: Codable, Hashable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
    
    var getCode: String {
        switch self {
        case .integer(let int):
            return "\(int)"
        case .string(let string):
            return string
        }
    }
}
