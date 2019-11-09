//
//  MainViewController.swift
//  Virta
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController, ViewController {
    
    // MARK: - ViewController
    
    func autolayoutSubviews() {
        
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        #if DEBUG
        print("Main view did load")
        #endif
    }
}
