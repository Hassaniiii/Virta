//
//  MainCoordinator.swift
//  Virta
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    private var navigationController: UINavigationController!
    private let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - ListViewController
    
    private lazy var stationsViewController: StationsListViewController = {
        let stationsViewController = Storyboard.main.instantiateViewController() as StationsListViewController
        stationsViewController.title = "Nearby".localized
        stationsViewController.viewModel = stationsViewModel
        stationsViewController.onStationTapped
            .receive(on: RunLoop.main)
            .sink { [weak self] station in
                self?.showDetailsViewController(for: station)
            }
            .cancel()
        stationsViewController.navigationItem.hidesBackButton = true
        return stationsViewController
    }()
    private lazy var stationsViewModel: StationsListViewModel = {
        let viewModel = StationsListViewModelImpl()
        viewModel.locationService = LocationServiceImpl()
        
        return viewModel
    }()
    
    func start() {
        navigationController = UINavigationController(rootViewController: stationsViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(stationsViewController, animated: true)
    }
    
    // MARK: - DetailsViewController
    
    private lazy var stationDetailsViewController: StationDetailsViewController = {
        let detailsViewController = Storyboard.main.instantiateViewController() as StationDetailsViewController
        detailsViewController.viewModel = StationDetailsViewModelImpl()
        
        return detailsViewController
    }()
    
    func showDetailsViewController(for station: StationsListModel) {
        DispatchQueue.main.async {
            self.stationDetailsViewController.station = station
            self.stationDetailsViewController.modalTransitionStyle = .coverVertical
            self.navigationController.present(self.stationDetailsViewController, animated: true, completion: nil)
        }
    }
}
