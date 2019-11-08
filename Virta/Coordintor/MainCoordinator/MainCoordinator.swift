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
    
    func start() {        
        window.rootViewController = mainViewController
        window.makeKeyAndVisible()
    }
    
    func start(with navigationController: UINavigationController) {
        #if DEBUG
        print("Main Coordinator Started with Navigation")
        #endif
    }
}
