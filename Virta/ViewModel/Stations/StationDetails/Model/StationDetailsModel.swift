//
//  StationDetailsModel.swift
//  Virta
//
//  Created by Hassaniiii on 11/10/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Foundation

// MARK: - StationsModel
struct StationDetailsModel: Codable {
    let id: Int
    let name: String
    let latitude, longitude: Double
    let icon: Int
    let address, city, openHours, providers: String
    let pictures: [Data]
    let isV2G: Bool
    let termsAndConditionsURLActingEmp: Bool?
    let evses: [StationDetailsEvse]

    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude, icon, address, city, openHours, providers, pictures, isV2G
        case termsAndConditionsURLActingEmp = "termsAndConditionsUrlActingEmp"
        case evses
    }
}

// MARK: - Evse
struct StationDetailsEvse: Codable {
    let id: Int
    let connectors: [StationDetailsConnector]
    let available, reservable, reserved, occupied: Bool
    let isV2G: Bool
    let pricing: [Pricing]
    let oneTimePayment, oneTimePaymentInAppEnabled: Bool
    let status, oneTimeMinimum: Int
    let oneTimePricing: [Pricing]
    let oneTimePricingRatio: Double
    let minutesWithoutTimeCharge: Int
    let evseID: String

    enum CodingKeys: String, CodingKey {
        case id, connectors, available, reservable, reserved, occupied, isV2G, pricing, oneTimePayment, oneTimePaymentInAppEnabled, status, oneTimeMinimum, oneTimePricing, oneTimePricingRatio, minutesWithoutTimeCharge
        case evseID = "evseId"
    }
}

// MARK: - Connector
struct StationDetailsConnector: Codable {
    let connectorID: Int
    let type: String
    let maxKwh, maxKw: Double?
    let currentType, status: String?
}

// MARK: - Pricing
struct Pricing: Codable {
    let name: String
    let priceCents: Int
    let currency: String
}
