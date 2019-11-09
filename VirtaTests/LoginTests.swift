//
//  LoginTests.swift
//  VirtaTests
//
//  Created by Hassaniiii on 11/9/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import XCTest
@testable import Virta

class LoginTests: XCTestCase {

    private var loginService: LoginService!
    private var loginViewModel: LoginViewModel!
    
    override func setUp() {
        loginService = LoginServiceImpl()
        loginViewModel = LoginViewModelImpl()
    }

    override func tearDown() { }

    func testService() {
        let expectations = self.expectation(description: "Expect to get a failure for invalid credentials")
        
        loginService.login(username: "mock", password: "mock")
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(err) = completion {
                    XCTAssertNotNil(err)
                }
                expectations.fulfill()
            }, receiveValue: { _ in
                XCTFail()
            })
            .cancel()
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testViewModelValidation() {
        let expectation = self.expectation(description: "Expect to get an error for invalid inputs")
        
        loginViewModel.username = "not empty"
        loginViewModel.password = ""
        loginViewModel.credentialValidate
            .sink { isValidated in
                XCTAssertFalse(isValidated)
                expectation.fulfill()
            }
            .cancel()
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testViewModelService() {
        let expectation = self.expectation(description: "Expect to get an error for wrong credentials")
        
        loginViewModel.login
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(err) = completion {
                    XCTAssertNotNil(err)
                }
                expectation.fulfill()
            }, receiveValue: { _ in
                XCTFail()
            })
            .cancel()
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
