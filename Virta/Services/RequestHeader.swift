//
//  RequestHeader.swift
//  Ninchat
//
//  Created by Hassaniiii on 10/25/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Foundation

protocol RequestHeader {
    init(_ headerSet: HeaderSet)
}

extension RequestHeader {
    init() {
        self.init(.defaultHeader)
    }
}

struct RequestHeaderImpl: RequestHeader {
    
    public var headers: [String:String]! = [:]
    
    // MARK: - Initialization
    
    init(_ headerSet: HeaderSet) {
        switch headerSet {
        case .defaultHeader:
            self.headers = self.commonHeaders
        case .authorizedHeader(let token):
            self.headers = self.commonHeaders
            self.headers[HeaderType.authorization.rawValue] = token
        }
    }
    
    // MARK: - Header derivation
    
    private var commonHeaders: [String:String] {
        return [HeaderType.contentType.rawValue: ContentType.applicationJSON.rawValue]
    }
}


enum HeaderSet {
    case defaultHeader
    case authorizedHeader(String)
}

enum HeaderType: String {
    case contentType = "content-type"
    case authorization = "Authorization"
}

enum ContentType: String {
    case applicationJSON = "application/json"
}
