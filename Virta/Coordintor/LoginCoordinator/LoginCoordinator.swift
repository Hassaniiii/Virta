//
//  LoginCoordinator.swift
//  Virta
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Combine
import UIKit

final class LoginCoordinator: Coordinator {
    
    private let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    private lazy var loginViewController: LoginViewController = {
        let view = Storyboard.main.instantiateViewController() as LoginViewController
        view.viewModel = LoginViewModelImpl()
        view.loginResult
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                if result {  self?.startMainCoordinator() }
            }
            .cancel()
        
        return view
    }()
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        return navigationController
    }()
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start(with navigationController: UINavigationController) {}
    
    // MARK: - Navigation
    
    func startMainCoordinator() {
        MainCoordinator(window: self.window).start(with: navigationController)
    }
}
