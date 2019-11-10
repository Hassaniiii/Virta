//
//  StationDetailsViewModel.swift
//  Virta
//
//  Created by Hassaniiii on 11/10/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Foundation
import Combine

protocol StationDetailsViewModel {
    var loading: PassthroughSubject<Bool, Never> { get }
    
    func details(for station: StationsListModel) -> AnyPublisher<StationDetailsModel, APIError>
}

final class StationDetailsViewModelImpl: StationDetailsViewModel {
    
    private let stationService: StationService = StationServiceImpl()
    
    // MARK: - StationDetailsViewModel
    
    var loading = PassthroughSubject<Bool, Never>()
    func details(for station: StationsListModel) -> AnyPublisher<StationDetailsModel, APIError> {
        return stationService.fetchDetails(for: station)
            .receive(on: RunLoop.main)
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.loading.send(true)
            }, receiveCompletion: { [weak self] _ in
                self?.loading.send(false)
            }, receiveCancel: { [weak self] in
                self?.loading.send(false)
            })
            .eraseToAnyPublisher()
    }
}
