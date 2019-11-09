//
//  LoginViewModel.swift
//  Virta
//
//  Created by Hassaniiii on 11/9/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Foundation
import Combine

protocol LoginViewModel {
    var username: String { get set }
    var password: String { get set }
    var credentialValidate: AnyPublisher<Bool, Never> { get }
    var loading: PassthroughSubject<Bool, Never> { get }
    var login: AnyPublisher<Bool, APIError> { get }
}

final class LoginViewModelImpl: LoginViewModel {
    
    private let loginService: LoginService = LoginServiceImpl()
    
    // MARK: - LoginViewModel
    
    @Published var username: String = ""
    @Published var password: String = ""
    var credentialValidate: AnyPublisher<Bool, Never> {
        return $username.combineLatest($password) { username, password in
            return !username.isEmpty && !password.isEmpty
        }.eraseToAnyPublisher()
    }
    
    var loading = PassthroughSubject<Bool, Never>()
    var login: AnyPublisher<Bool, APIError> {
        return loginService.login(username: username, password: password)
            .receive(on: RunLoop.main)
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.loading.send(true)
            }, receiveOutput: { token in
                if !token.token.isEmpty {
                    KeychainWrapeprImpl().set(value: token.token, for: Constants.authorizationKey)
                }
            }, receiveCompletion: { [weak self] _ in
                self?.loading.send(false)
            }, receiveCancel: { [weak self] in
                self?.loading.send(false)
            })
            .map { token in
                return !token.token.isEmpty
            }
            .eraseToAnyPublisher()
    }
}
