//
//  StationsTableViewCell.swift
//  Virta
//
//  Created by Hassaniiii on 11/9/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit
import Combine


final class StationsListTableViewCell: UITableViewCell {
    
    var station: StationsListModel! {
        didSet {
            self.viewBuilder()
            stationTitle.text = station.name
            stationAddress.text = station.address
            stationDistance.text = station.distanceKM ?? ""
//            stationEvses.reloadData()
            self.viewConfiguration()
        }
    }
    
    // MARK: - Views
    
    private var containerView: UIView!
    private var stationTitle: UILabel!
    private var stationAddress: UILabel!
    private var stationDetails: UIButton!
    private var stationDistance: UILabel!
    private var stationEvses: UICollectionView!
    
    func viewBuilder() {
        self.subviews.forEach { $0.removeFromSuperview() }
        
        self.containerView = containerViewBuilder()
        self.addSubview(containerView)
        
        self.stationTitle = titleBuilder(.boldSystemFont(ofSize: 14.0))
        containerView.addSubview(stationTitle)
        
        self.stationAddress = titleBuilder(.systemFont(ofSize: 12.0))
        containerView.addSubview(stationAddress)
        
        self.stationDetails = detailsBuilder()
        containerView.addSubview(stationDetails)
        
        self.stationDistance = titleBuilder(.systemFont(ofSize: 9.0), alignment: .right)
        self.stationDistance.textColor = #colorLiteral(red: 0.319334656, green: 0.569334507, blue: 1, alpha: 1)
        containerView.addSubview(stationDistance)
        
//        self.stationEvses = evseViewBuilder()
//        containerView.addSubview(stationEvses)
    }
    
    func viewConfiguration() {
        self.backgroundColor = .clear
        
        containerView
            .fix(top: (1.0, self), bottom: (1.0, self), isRelative: false)
            .fix(left: (0.0, self), right: (0.0, self))

        stationTitle
            .fix(top: (4.0, containerView), isRelative: false)
            .fix(left: (4.0, containerView))
            .fix(right: (4.0, stationDistance), isRelative: true)
            .fix(height: 24.0)

        stationAddress
            .fix(top: (0.0, stationTitle))
            .fix(left: (4.0, containerView))
            .fix(height: 21.0)

//        stationEvses
//            .fix(left: (0.0, containerView), right: (0.0, containerView), isRelative: false)
//            .fix(top: (8.0, stationAddress), isRelative: true)
        
        stationDetails
            .fix(top: (4.0, containerView), isRelative: false)
            .fix(right: (4.0, containerView))
            .fix(width: 24.0, height: 24.0)

        stationDistance
            .fix(top: (4.0, containerView), isRelative: false)
            .fix(right: (4.0, stationDetails), isRelative: true)
            .fix(height: 24.0)
    }
}

extension StationsListTableViewCell {
    private func containerViewBuilder() -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        
        return view
    }
    private func evseViewBuilder() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let containerView = StationsListEvsesCollectionView(frame: .zero, collectionViewLayout: layout)
        containerView.register(StationsListEvsesCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: StationsListEvsesCollectionViewCell.self))
        containerView.delegate = self
        containerView.dataSource = self
        
        return containerView
    }
    private func titleBuilder(_ font: UIFont, alignment: NSTextAlignment = .left) -> UILabel {
        let view = UILabel(frame: .zero)
        view.textAlignment = alignment
        view.font = font
        
        return view
    }
    private func detailsBuilder() -> UIButton {
        let view = UIButton(frame: .zero)
        view.setTitle("", for: .normal)
        view.setImage(#imageLiteral(resourceName: "icNavigate.jpg"), for: .normal)
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        view.layer.cornerRadius = view.frame.width / 2
        
        return view
    }
}

extension StationsListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return station.evses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        cell.backgroundColor = .yellow
        
        return cell
    }
}

extension StationsListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
