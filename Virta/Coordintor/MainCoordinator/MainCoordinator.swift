//
//  MainCoordinator.swift
//  Virta
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    private let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    private lazy var mainViewController: MainViewController = {
        return Storyboard.main.instantiateViewController()
    }()
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        return navigationController
    }()
    
    func start() {        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start(with navigationController: UINavigationController) {
        navigationController.pushViewController(mainViewController, animated: true)
    }
}
