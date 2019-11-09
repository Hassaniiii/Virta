//
//  UIView+AutoLayout.swift
//  Virta
//
//  Created by Hassaniiii on 11/9/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    func fix(width: CGFloat = 0, height: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        if width > 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height > 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        return self
    }
    
    @discardableResult
    func fix(left: (value: CGFloat, toView: UIView)? = nil, right: (value: CGFloat, toView: UIView)? = nil) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let leftSide = left {
            let (value, toView) = leftSide
            self.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: value).isActive = true
        }
        if let rightSide = right {
            let (value, toView) = rightSide
            self.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -value).isActive = true
        }
        return self
    }
    
    @discardableResult
    func fix(top: (value: CGFloat, toView: UIView)? = nil, bottom: (value: CGFloat, toView: UIView)? = nil, isRelative: Bool = true) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let topSide = top {
            let (value, toView) = topSide
            self.topAnchor.constraint(equalTo: isRelative ? toView.bottomAnchor : toView.topAnchor, constant: value).isActive = true
        }
        if let bottomSide = bottom {
            let (value, toView) = bottomSide
            self.bottomAnchor.constraint(equalTo: isRelative ? toView.topAnchor : toView.bottomAnchor, constant: -value).isActive = true
        }
        return self
    }
    
    @discardableResult
    func center(toX: UIView? = nil, toY: UIView? = nil) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let view = toX {
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        }
        if let view = toY {
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        }
        return self
    }
}
