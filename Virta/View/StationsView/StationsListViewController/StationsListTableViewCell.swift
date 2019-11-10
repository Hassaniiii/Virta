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
            self.viewConfiguration()
        }
    }
    
    // MARK: - Views
    
    private var containerView: UIView!
    private var stationEvses: UIView!
    private lazy var stationTitle: UILabel = {
        return titleBuilder(.boldSystemFont(ofSize: 14.0))
    }()
    private lazy var stationAddress: UILabel = {
        return titleBuilder(.systemFont(ofSize: 12.0))
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
        let view = titleBuilder(.systemFont(ofSize: 9.0), alignment: .right)
        view.textColor = #colorLiteral(red: 0.319334656, green: 0.569334507, blue: 1, alpha: 1)
        
        return view
    }()
    
    func viewBuilder() {
        if self.subviews.count > 0 {
            self.subviews.forEach { $0.removeFromSuperview() }
        }
        
        self.containerView = containerViewBuilder()
        self.addSubview(containerView)
        containerView.addSubview(stationTitle)
        containerView.addSubview(stationAddress)
        containerView.addSubview(stationDetails)
        containerView.addSubview(stationDistance)
        
        self.stationEvses = evseContainerView()
        containerView.addSubview(stationEvses)
    }
    
    func viewConfiguration() {
        self.backgroundColor = .clear
        
        containerView
            .fix(top: (1.0, self), bottom: (1.0, self), isRelative: false)
            .fix(left: (0.0, self), right: (0.0, self))

        stationTitle
            .fix(top: (4.0, containerView), isRelative: false)
            .fix(left: (8.0, containerView))
            .fix(right: (2.0, stationDistance), isRelative: true)
            .fix(height: 24.0)

        stationAddress
            .fix(top: (4.0, stationTitle))
            .fix(left: (8.0, containerView))
            .fix(height: 21.0)

        stationEvses
            .fix(left: (8.0, containerView), isRelative: false)
            .fix(top: (8.0, stationAddress), isRelative: true)
        
        stationDetails
            .fix(top: (4.0, containerView), isRelative: false)
            .fix(right: (8.0, containerView))
            .fix(width: 24.0, height: 24.0)

        stationDistance
            .fix(top: (4.0, containerView), isRelative: false)
            .fix(right: (8.0, stationDetails), isRelative: true)
            .fix(height: 24.0)
    }
}

extension StationsListTableViewCell {
    private func containerViewBuilder() -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        
        return view
    }
    private func titleBuilder(_ font: UIFont, alignment: NSTextAlignment = .left) -> UILabel {
        let view = UILabel(frame: .zero)
        view.textAlignment = alignment
        view.font = font
        
        return view
    }
    
    private func evseContent(_ kw: Double, count: Int) -> UIView {
        let containerView = UIStackView(frame: .zero)
        containerView.axis = .horizontal
        containerView.distribution = .fillEqually
        containerView.spacing = 4.0
        
        let imageContainer = UIStackView(frame: .zero)
        imageContainer.axis = .vertical
        imageContainer.distribution = .fill
        let icon = UIImageView(image: #imageLiteral(resourceName: "icType2.jpg"))
        icon.contentMode = .scaleAspectFit
        let number = UILabel(frame: .zero)
        number.textAlignment = .center
        number.font = UIFont.systemFont(ofSize: 8.0)
        number.text = "×\(count)"
        
        let kwContainer = UIStackView(frame: .zero)
        kwContainer.axis = .vertical
        kwContainer.distribution = .fill
        let kwValue = UILabel(frame: .zero)
        kwValue.textAlignment = .center
        kwValue.font = UIFont.boldSystemFont(ofSize: 30.0)
        kwValue.text = kw.clean
        let kwTitle = UILabel(frame: .zero)
        kwTitle.textAlignment = .center
        kwTitle.font = UIFont.systemFont(ofSize: 8.0)
        kwTitle.text = "KW"
            
        imageContainer.addArrangedSubview(icon)
        if count > 1 {
            imageContainer.addArrangedSubview(number.fix(height: 10.0))
        }
        kwContainer.addArrangedSubview(kwValue)
        kwContainer.addArrangedSubview(kwTitle.fix(height: 10.0))
        
        containerView.addArrangedSubview(imageContainer)
        containerView.addArrangedSubview(kwContainer)
        
        return containerView
    }
    private func evseRow(from stack: [UIView]) -> UIView {
        let containerView = UIStackView(frame: .zero)
        containerView.axis = .horizontal
        containerView.distribution = .fill
        containerView.spacing = 16.0
        
        stack.forEach { containerView.addArrangedSubview($0) }
        return containerView
    }
    private func evseContainerView() -> UIView {
        let containerView = UIStackView(frame: .zero)
        containerView.axis = .vertical
        containerView.distribution = .fill
        containerView.spacing = 2.0
        
        var rowItems: [UIView] = []
        for (key, value) in station.distinctEvsePoints {
            if rowItems.count == 3 {
                containerView.addArrangedSubview(evseRow(from: rowItems))
                rowItems.removeAll()
            }
            rowItems.append(evseContent(key, count: value))
        }
        containerView.addArrangedSubview(evseRow(from: rowItems))
        
        return containerView
    }
}

