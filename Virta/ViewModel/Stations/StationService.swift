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
    func fetchStations(page: Int, perPage: Int) -> AnyPublisher<[StationsListModel], APIError>
    func fetchDetails(for station: StationsListModel) -> AnyPublisher<StationDetailsModel, APIError>
}
extension StationService {
    private var perPage: Int {
        return 500
    }
    
    func fetchStations(page: Int) -> AnyPublisher<[StationsListModel], APIError> {
        return self.fetchStations(page: page, perPage: perPage)
    }
}

struct StationServiceImpl: StationService {
    
    private let locationService: LocationService?
    private let service: ServiceManager = ServiceManagerImpl()
    
    init() {
        self.locationService = nil
    }
    
    init(locationService: LocationService) {
        self.locationService = locationService
    }
    
    func fetchStations(page: Int, perPage: Int) -> AnyPublisher<[StationsListModel], APIError> {
        let request = StationsListRequest(page: page, perPage: perPage, location: locationService!.locationValue)
        return service.performRequest(request)
    }
    
    func fetchDetails(for station: StationsListModel) -> AnyPublisher<StationDetailsModel, APIError> {
        let request = StationDetailsRequest(station)
        return service.performRequest(request)
    }
}
