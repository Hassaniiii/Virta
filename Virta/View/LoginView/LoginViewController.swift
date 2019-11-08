//
//  LoginViewController.swift
//  Virta
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController, ViewController {
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
        print("Login view did load")
        #endif
    }
}
