//
//  SelfConfiguringCell.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 02/03/2022.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with user: User)
}
