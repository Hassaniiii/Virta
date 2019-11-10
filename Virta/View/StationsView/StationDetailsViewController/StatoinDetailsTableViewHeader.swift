//
//  StatoinDetailsTableViewHeader.swift
//  Virta
//
//  Created by Hassaniiii on 11/10/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

final class StationDetailsTableViewHeader: UIView {
    
    var station: StationsListModel! {
        didSet {
            self.viewBuilder()
            stationTitle.text = station.name
            stationAddress.text = station.address
            stationDistance.text = station.distanceKM ?? ""
            self.viewConfiguration()
        }
    }
    
    // MARK: - Views
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        
        return view
    }()
    private lazy var stationTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        return view
    }()
    private lazy var stationAddress: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 12.0)
        
        return view
    }()
    private lazy var stationDetails: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("", for: .normal)
        view.setImage(#imageLiteral(resourceName: "icNavigate.jpg"), for: .normal)
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        view.layer.cornerRadius = view.frame.width / 2
        
        return view
    }()
    private lazy var stationDistance: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .right
        view.font = UIFont.systemFont(ofSize: 9.0)
        view.textColor = #colorLiteral(red: 0.319334656, green: 0.569334507, blue: 1, alpha: 1)
        
        return view
    }()
    
    func viewBuilder() {
        self.addSubview(containerView)
        containerView.addSubview(stationTitle)
        containerView.addSubview(stationAddress)
        containerView.addSubview(stationDetails)
        containerView.addSubview(stationDistance)
    }
    
    func viewConfiguration() {
        containerView
            .fix(top: (0.0, self), bottom: (0.0, self), isRelative: false)
            .fix(left: (0.0, self), right: (0.0, self))

        stationTitle
            .fix(top: (4.0, containerView), isRelative: false)
            .fix(left: (4.0, containerView))
            .fix(height: 24.0)

        stationAddress
            .fix(top: (0.0, stationTitle))
            .fix(left: (4.0, containerView))
            .fix(height: 21.0)

        stationDetails
            .fix(bottom: (4.0, containerView), isRelative: false)
            .fix(right: (4.0, containerView))
            .fix(width: 24.0, height: 24.0)

        stationDistance
            .fix(bottom: (4.0, containerView), isRelative: false)
            .fix(right: (4.0, stationDetails), isRelative: true)
            .fix(height: 24.0)
    }
}
