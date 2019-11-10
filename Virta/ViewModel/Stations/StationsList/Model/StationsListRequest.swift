//
//  StationRequest.swift
//  Virta
//
//  Created by Hassaniiii on 11/9/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import CoreLocation

struct StationsListRequest: Request {
    typealias ReturnType = [StationsListModel]
    typealias BodyType = EmptyModel
    
    var path: String = "/stations"
    var httpMethod: HTTPMethod = .get
    var headers: [String : String]?
    var bodyJSON: BodyType?
    
    init(page: Int, perPage: Int, location: CLLocation?) {
        guard let token = KeychainWrapeprImpl().getValue(for: Constants.AuthorizationKey) else {
            fatalError("Token cannot be null")
        }
        headers = RequestHeaderImpl(.authorizedHeader(token)).headers
        path += "?from=\(page)&limit=\(perPage)"
        if let location = location {
            path += "&latMax=\(location.coordinate.latitude)&longMax=\(location.coordinate.longitude)"
        }
    }
}
