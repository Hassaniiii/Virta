//
//  StationDetailsTableViewCell.swift
//  Virta
//
//  Created by Hassaniiii on 11/10/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

final class StationDetailsTableViewCell: UITableViewCell {
    
    var evse: StationDetailsEvse! {
        didSet {
            self.viewBuilder()
            evseID.text = "\(evse.id)"
            self.viewConfiguration()
        }
    }
    
    // MARK: - Views
    
    private var containerView: UIView!
    private var evseID: UILabel!
    
    func viewBuilder() {
        self.containerView = containerViewBuilder()
        self.addSubview(containerView)
        
        self.evseID = labelBuilder()
        containerView.addSubview(evseID)
    }
    
    func viewConfiguration() {
        self.backgroundColor = .clear
        
        containerView
            .fix(top: (1.0, self), bottom: (1.0, self), isRelative: false)
            .fix(left: (0.0, self), right: (0.0, self))

        evseID
            .fix(left: (16.0, containerView), isRelative: false)
            .center(toY: containerView)
            .fix(width: evseID.intrinsicContentSize.width * 1.3, height: 24.0)
    }
}

extension StationDetailsTableViewCell {
    private func containerViewBuilder() -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        
        return view
    }
    
    private func labelBuilder() -> UILabel {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 14.0)
        view.layer.masksToBounds = true
        view.layer.borderWidth = 3.5
        
        return view
    }
}
