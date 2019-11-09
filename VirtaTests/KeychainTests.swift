//
//  KeychainTests.swift
//  VirtaTests
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import XCTest
@testable import Virta

class KeychainTests: XCTestCase {
    
    private var keychain: KeychainWrapper!
    
    override func setUp() {
        keychain = KeychainWrapeprImpl()
    }

    override func tearDown() {}

    func testKeychain() {
        let mockDataValue = "MockValue"
        let mockDataKey = "MockKey"
        
        keychain.set(value: mockDataValue, for: mockDataKey)
        XCTAssertEqual(mockDataValue, keychain.getValue(for: mockDataKey))
    }
}
