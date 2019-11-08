//
//  SceneDelegate.swift
//  Virta
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private lazy var appCoordinator: Coordinator = {
        guard let window = self.window else {
            fatalError("Window cannot be null")
        }
        return AppCoordinator(window: window)
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.appCoordinator.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

