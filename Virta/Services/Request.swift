//
//  Request.swift
//  Ninchat
//
//  Created by Hassaniiii on 10/25/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get, post, delete, put
}

protocol Request {
    associatedtype ReturnType: Decodable
    associatedtype BodyType: Encodable
    
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String:String]? { get }
    var bodyJSON: BodyType? { get }
}

extension Request {
    var host: String {
        return "https://apitest.virta.fi/v4"
    }
    
    var body: Data? {
        return try? JSONEncoder().encode(bodyJSON)
    }
}
