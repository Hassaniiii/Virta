//
//  LoginViewController.swift
//  Virta
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit
import Combine

final class LoginViewController: UIViewController, ViewController {
    
    // MARK: - Injected
    
    var viewModel: LoginViewModel!
    let loginResult = PassthroughSubject<Bool, Never>()
    
    // MARK: - Views
    
    private lazy var pageTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 16.0)
        view.text = "Login and Charge!".localized
        
        return view
    }()
    private lazy var loginLogo: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = #imageLiteral(resourceName: "logIn.jpg")
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    private lazy var userNameField: UITextField = {
        let view = UITextField(frame: .zero)
        view.placeholder = "Username".localized
        view.returnKeyType = .next
        view.enablesReturnKeyAutomatically = true
        view.delegate = self
        view.addTarget(self, action: #selector(onUsernameTextChanged(_:)), for: .editingChanged)
        
        return view
    }()
    private lazy var passwordField: UITextField = {
        let view = UITextField(frame: .zero)
        view.placeholder = "Password".localized
        view.isSecureTextEntry = true
        view.returnKeyType = .done
        view.enablesReturnKeyAutomatically = true
        view.delegate = self
        view.addTarget(self, action: #selector(onPasswordTextChanged(_:)), for: .editingChanged)
        
        return view
    }()
    private lazy var credentialContainer: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.spacing = 8.0
        
        let userNameView = UIStackView(frame: .zero)
        userNameView.axis = .horizontal
        userNameView.spacing = 8.0
        userNameView.addArrangedSubview(UIImageView(image: #imageLiteral(resourceName: "icPerson.jpg")).fix(width: 40.0))
        userNameView.addArrangedSubview(userNameField)
        
        let passwordView = UIStackView(frame: .zero)
        passwordView.axis = .horizontal
        passwordView.spacing = 8.0
        passwordView.addArrangedSubview(UIImageView(image: #imageLiteral(resourceName: "icLock.jpg")).fix(width: 40.0))
        passwordView.addArrangedSubview(passwordField)
        
        view.addArrangedSubview(userNameView.fix(height: 40.0))
        view.addArrangedSubview(UIView.`init`(.lightGray).fix(height: 1.0))
        view.addArrangedSubview(passwordView.fix(height: 40.0))
        view.addArrangedSubview(UIView.`init`(.lightGray).fix(height: 1.0))
        return view
    }()
    private lazy var loginBtn: UIButton = {
        let view = UIButton(frame: .zero)
        view.backgroundColor = .yellow
        view.setTitleColor(.black, for: .normal)
        view.setTitle("Login".localized, for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        view.addTarget(self, action: #selector(onLoingButtonTapped(_:)), for: .touchUpInside)
        
        return view
    }()
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .gray
        view.hidesWhenStopped = true
        
        return view
    }()
    
    // MARK: - ViewController
    
    func autolayoutSubviews() {
        self.view.addSubview(pageTitle)
        pageTitle
            .fix(left: (8.0, self.view), right: (8.0, self.view))
            .fix(top: (32.0, self.view), isRelative: false)
            .center(toX: self.view)
        
        self.view.addSubview(loginLogo)
        loginLogo
            .fix(width: 150.0, height: 150.0)
            .fix(top: (16.0, self.pageTitle))
            .center(toX: self.view)
        
        self.view.addSubview(credentialContainer)
        credentialContainer
            .fix(left: (8.0, self.view), right: (8.0, self.view))
            .fix(top: (16.0, self.loginLogo))
        
        self.view.addSubview(loginBtn)
        loginBtn
            .fix(top: (32.0, credentialContainer))
            .fix(width: 150.0, height: 38.0)
            .center(toX: self.view)
        
        self.view.addSubview(loadingIndicator)
        loadingIndicator
            .center(toX: loginBtn, toY: loginBtn)
    }
    
    // MARK: - UIViewController
    
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.autolayoutSubviews()
        self.viewModel.credentialValidate
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: loginBtn)
            .store(in: &cancellable)
        self.viewModel.loading
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] isLoading in
                isLoading ? self?.loadingIndicator.startAnimating() : self?.loadingIndicator.stopAnimating()
                self?.loginBtn.setTitle(isLoading ? "" : "Login".localized, for: .normal)
            })
            .store(in: &cancellable)
    }
    
    deinit {
        cancellable.forEach { $0.cancel() }
    }
    
    // MARK: - User actions
    
    @objc
    func onUsernameTextChanged(_ sender: Any) {
        viewModel.username = userNameField.text ?? ""
    }
    @objc
    func onPasswordTextChanged(_ sender: Any) {
        viewModel.password = passwordField.text ?? ""
    }
    @objc
    func onLoingButtonTapped(_ sender: Any) {
        self.viewModel.login
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    let alert = UIAlertController(title: "Error".localized, message: error.errorDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            })
            { [weak self] result in
                self?.loginResult.send(result)
            }
            .store(in: &cancellable)
    }
}



extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            passwordField.resignFirstResponder()
            self.onLoingButtonTapped(textField)
        }
        
        return true
    }
}
