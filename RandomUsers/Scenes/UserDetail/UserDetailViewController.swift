//
//  UserDetailViewController.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 02/03/2022.
//

import Foundation

import UIKit
import Combine

final class UserDetailViewController: UIViewController {
    private lazy var contentView = UserDetailView()
    private var show = false
    var user: User?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user {
            contentView.configure(with: user)
            title = user.name.fullName
        }
        setUpTargets()
    }
    
    
    private func setUpTargets() {
        contentView.userLoginView.showMoreButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
    @objc private func onClick() {
         show.toggle()
        contentView.shouldShowMore(show)
    }
}
