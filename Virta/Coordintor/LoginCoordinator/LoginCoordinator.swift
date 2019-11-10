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
    
    private var navigationController: UINavigationController!
    private let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    private lazy var loginViewController: LoginViewController = {
        let view = Storyboard.main.instantiateViewController() as LoginViewController
        view.viewModel = loginViewModel
        view.loginResult
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                if result { self?.startMainCoordinator() }
            }
            .cancel()
        
        return view
    }()
    private lazy var loginViewModel: LoginViewModel = {
        let viewModel = LoginViewModelImpl()
        
        return viewModel
    }()
    
    func start() {
        navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start(with navigationController: UINavigationController) {}
    
    // MARK: - Navigation
    
    private lazy var mainCoordinator: Coordinator = {
        return MainCoordinator(window: self.window)
    }()
    
    func startMainCoordinator() {
        DispatchQueue.main.async {
            self.mainCoordinator.start(with: self.navigationController)
        }
    }
}
