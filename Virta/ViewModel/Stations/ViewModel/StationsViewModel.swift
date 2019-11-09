//
//  StationsViewModel.swift
//  Virta
//
//  Created by Hassaniiii on 11/9/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

protocol StationsViewModel {
    var locationService: LocationService! { get set }
    var loading: PassthroughSubject<Bool, Never> { get }
    
    func stations(at page: Int) -> AnyPublisher<[StationModel], APIError>
}

final class StationsViewModelImpl: StationsViewModel {
    
    private lazy var stationService: StationService = {
        return StationServiceImpl(locationService: self.locationService)
    }()
    
    // MARK: - StationsViewModel
    
    var locationService: LocationService!
    var loading = PassthroughSubject<Bool, Never>()
    func stations(at page: Int) -> AnyPublisher<[StationModel], APIError> {
        return stationService.fetchStations(page: page)
            .receive(on: RunLoop.main)
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.loading.send(true)
            }, receiveCompletion: { [weak self] _ in
                self?.loading.send(false)
            }, receiveCancel: { [weak self] in
                self?.loading.send(false)
            })
            .map { (list: [StationModel]) -> [StationModel] in
                list.map { [weak self] in
                    let itemLocation = CLLocation(latitude: $0.latitude, longitude: $0.longitude)
                    if let currentLocation = self?.locationService.locationValue {
                        let distance: Double = itemLocation.distance(from: currentLocation) / 1000
                        return StationModel($0, distance: distance)
                    }
                    return $0
                }
            }
            .map {
                $0.sorted { $0.distance ?? 0 < $1.distance ?? 0 }
            }
            .eraseToAnyPublisher()
    }
}
