//
//  MainCoordinator.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//

import Foundation
import UIKit

enum ScreenFlow {
    case userList
    case userDetail(User)
}

protocol AppNavigationFlow {
    func createView(for screen: ScreenFlow) -> UIViewController
}

final class MainCoordinator: AppNavigationFlow {
    
    func createView(for screen: ScreenFlow) -> UIViewController {
        switch screen {
        case .userList:
            return UserListViewController()
        case .userDetail(let user):
            let controller = UserDetailViewController()
            controller.user = user
            return controller
        }
    }
}
