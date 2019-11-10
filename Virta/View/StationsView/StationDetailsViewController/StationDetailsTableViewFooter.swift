//
//  StationDetailsTableViewFooter.swift
//  Virta
//
//  Created by Hassaniiii on 11/10/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

final class StationDetailsTableViewFooter: UIView {
    
    var stationDetails: StationDetailsModel? {
        didSet {
            guard let stationDetails = stationDetails else { return }
            
            self.viewBuilder()
            self.providerTitle.text = stationDetails.providers
            self.viewConfiguration()
        }
    }
    
    // MARK: - Views
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        
        return view
    }()
    private lazy var pageTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 16.0)
        view.text = "Info and Help".localized
        
        return view
    }()
    private lazy var providerTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 16.0)
        
        return view
    }()
    private lazy var providerSubtitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 12.0)
        view.text = "Provider".localized
        view.textColor = .lightGray
        
        return view
    }()
    private var howToUse: UIView!
    private var reportAbuse: UIView!
    
    func viewBuilder() {
        self.addSubview(containerView)
        containerView.addSubview(pageTitle)
        containerView.addSubview(providerTitle)
        containerView.addSubview(providerSubtitle)
        
        self.howToUse = viewBuilder(title: "How to Use".localized, subtitle: "We are always here to help".localized, image: #imageLiteral(resourceName: "icInfo.jpg"))
        containerView.addSubview(howToUse)
        
        self.reportAbuse = viewBuilder(title: "Report Abuse".localized, subtitle: "Something not perfect?".localized, image: #imageLiteral(resourceName: "icFeedbackSad.jpg"))
        containerView.addSubview(reportAbuse)
    }
    
    func viewConfiguration() {
        containerView
            .fix(top: (0.0, self), bottom: (0.0, self), isRelative: false)
            .fix(left: (0.0, self), right: (0.0, self), isRelative: false)
        
        pageTitle
            .fix(left: (8.0, containerView), isRelative: false)
            .fix(top: (4.0, containerView), isRelative: false)
            .fix(height: 24.0)
        
        providerTitle
            .fix(left: (8.0, containerView), isRelative: false)
            .fix(top: (16.0, pageTitle), isRelative: true)
            .fix(height: 20.0)
        
        providerSubtitle
            .fix(left: (8.0, containerView), isRelative: false)
            .fix(top: (2.0, providerTitle), isRelative: true)
            .fix(height: 16.0)
        
        howToUse
            .fix(left: (8.0, containerView), right: (8.0, self), isRelative: false)
            .fix(top: (16.0, providerSubtitle), isRelative: true)
        
        reportAbuse
            .fix(left: (8.0, containerView), right: (8.0, self), isRelative: false)
            .fix(top: (10.0, howToUse), isRelative: true)
    }
}

extension StationDetailsTableViewFooter {
    private func viewBuilder(title: String, subtitle: String, image: UIImage) -> UIView {
        let containerView = UIStackView(frame: .zero)
        containerView.axis = .horizontal
        containerView.distribution = .fill
        containerView.spacing = 12.0
        
        let icon = UIImageView(image: image)
        icon.contentMode = .scaleAspectFit
        
        let containerTextView = UIStackView(frame: .zero)
        containerTextView.axis = .vertical
        containerTextView.distribution = .fillEqually
        
        let titleView = UILabel(frame: .zero)
        titleView.text = title
        titleView.font = UIFont.boldSystemFont(ofSize: 14.0)
        titleView.textAlignment = .left
        
        let subtitleView = UILabel(frame: .zero)
        subtitleView.text = subtitle
        subtitleView.font = UIFont.systemFont(ofSize: 12.0)
        subtitleView.textAlignment = .left
        subtitleView.textColor = .lightGray
        
        let accessory = UIImageView(image: #imageLiteral(resourceName: "icChevronRight.jpg"))
        accessory.contentMode = .scaleAspectFit
        
        containerTextView.addArrangedSubview(titleView)
        containerTextView.addArrangedSubview(subtitleView)
        containerView.addArrangedSubview(icon.fix(width: 30))
        containerView.addArrangedSubview(containerTextView)
        containerView.addArrangedSubview(accessory.fix(width: 30))
        
        return containerView
    }
}
