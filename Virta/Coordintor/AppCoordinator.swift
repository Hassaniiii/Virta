//
//  AppCoordinator.swift
//  Virta
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    func start()
    func start(with navigationController: UINavigationController)
}
extension Coordinator {
    func start() {}
}

final class AppCoordinator: Coordinator {
    
    // MARK: - Initialiaztion
    
    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Coordinator
    
    private lazy var navigationController: UINavigationController = {
        return UINavigationController()
    }()
    private lazy var loginCoordinator: Coordinator = {
        return LoginCoordinator(window: self.window)
    }()
    private lazy var mainCoordinator: Coordinator = {
        return MainCoordinator(window: self.window)
    }()
    func start() {
        self.mainCoordinator.start()
    }
    
    func start(with navigationController: UINavigationController) {
        fatalError("Cannot access to `start(with:)` on AppCoordinator")
    }
}
