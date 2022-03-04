//
//  SceneDelegate.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//

import UIKit
import Resolver

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    @Injected private var coordinator: AppNavigationFlow
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: coordinator.createView(for: .userList))
        self.window = window
        window.makeKeyAndVisible()
    }
}

