//
//  StationDetailsRequest.swift
//  Virta
//
//  Created by Hassaniiii on 11/10/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Foundation

struct StationDetailsRequest: Request {
    typealias ReturnType = StationDetailsModel
    typealias BodyType = EmptyModel
    
    var path: String = "/stations/"
    var httpMethod: HTTPMethod = .get
    var headers: [String : String]?
    var bodyJSON: BodyType?
    
    init(_ station: StationsListModel) {
        guard let token = KeychainWrapepr.getValue(for: Constants.AuthorizationKey) else {
            fatalError("Token cannot be null")
        }
        headers = RequestHeaderImpl(.authorizedHeader(token)).headers
        path += "\(station.id)"
    }
}
