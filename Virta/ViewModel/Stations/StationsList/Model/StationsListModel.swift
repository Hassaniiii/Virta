//
//  StationsModel.swift
//  Virta
//
//  Created by Hassaniiii on 11/9/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Foundation

// MARK: - StationsModelElement
struct StationsListModel: Codable, Hashable {
    
    let id: Int
    let latitude, longitude: Double
    let icon: Int
    let name, city, address: String
    let provider: String
    let evses: [StationsListEvse]
    let isRemoved, isPrivate: Bool
    
    var distance: Double?
    var distanceKM: String?
    
    init(_ station: StationsListModel, distance: Double) {
        self.id = station.id
        self.latitude = station.latitude
        self.longitude = station.longitude
        self.icon = station.icon
        self.name = station.name
        self.city = station.city
        self.address = station.address
        self.provider = station.provider
        self.evses = station.evses
        self.isRemoved = station.isRemoved
        self.isPrivate = station.isPrivate
        
        self.distance = distance
        self.distanceKM = String(format: "%.2f KM", distance)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: StationsListModel, rhs: StationsListModel) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Evse
struct StationsListEvse: Codable {
    let id: Int
    let groupName: String
    let connectors: [StationListConnector]
}

// MARK: - Connector
struct StationListConnector: Codable {
    let type: String
    let maxKw: Double
}
