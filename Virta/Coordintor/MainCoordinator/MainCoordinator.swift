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
    
    private lazy var stationsViewController: StationsViewController = {
        let stationsViewController = Storyboard.main.instantiateViewController() as StationsViewController
        stationsViewController.title = "Nearby".localized
        stationsViewController.viewModel = stationsViewModel
        
        return stationsViewController
    }()
    private lazy var stationsViewModel: StationsViewModel = {
        let viewModel = StationsViewModelImpl()
        viewModel.locationService = LocationServiceImpl()
        
        return viewModel
    }()
    private lazy var navigationController: UINavigationController = {
        return UINavigationController(rootViewController: stationsViewController)
    }()
    
    func start() {        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start(with navigationController: UINavigationController) {
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(stationsViewController, animated: true)
    }
}
