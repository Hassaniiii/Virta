//
//  LoginCoordinator.swift
//  Virta
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    private let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    private lazy var loginViewController: LoginViewController = {
        return Storyboard.main.instantiateViewController()
    }()
    
    func start() {
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }
    
    func start(with navigationController: UINavigationController) {
        #if DEBUG
        print("Login Coordinator Start")
        #endif
        
//        let loginViewController: LoginViewController = Storyboard.main.instantiateViewController()
//        navigationController.
    }
}
