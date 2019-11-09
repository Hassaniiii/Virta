//
//  StationService.swift
//  Virta
//
//  Created by Hassaniiii on 11/9/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

protocol StationService {
    func fetchStations(page: Int, perPage: Int) -> AnyPublisher<[StationModel], APIError>
}
extension StationService {
    private var perPage: Int {
        return 100
    }
    
    func fetchStations(page: Int) -> AnyPublisher<[StationModel], APIError> {
        return self.fetchStations(page: page, perPage: perPage)
    }
}

struct StationServiceImpl: StationService {
    
    private let locationService: LocationService
    private let service: ServiceManager = ServiceManagerImpl()
    
    init(locationService: LocationService) {
        self.locationService = locationService
    }
    
    func fetchStations(page: Int, perPage: Int) -> AnyPublisher<[StationModel], APIError> {
        let request = StationRequest(page: page, perPage: perPage, location: locationService.locationValue)
        return service.performRequest(request)
    }
}
