//
//  StationDetailsViewController.swift
//  Virta
//
//  Created by Hassaniiii on 11/10/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit
import Combine

final class StationDetailsViewController: UIViewController, ViewController {
    
    // MARK: - Injected
    
    var station: StationsListModel! {
        didSet {
            tableViewHeader.station = station
        }
    }
    var viewModel: StationDetailsViewModel!
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.registerClass(StationDetailsTableViewCell.self)
        view.tableFooterView = tableViewFooter
        view.tableHeaderView = tableViewHeader
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.allowsSelection = false
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .gray
        view.hidesWhenStopped = true
        
        return view
    }()
    private let tableViewFooter = StationDetailsTableViewFooter(frame: CGRect(x: 0, y: 0, width: 0, height: 180))
    private let tableViewHeader = StationDetailsTableViewHeader(frame: CGRect(x: 0, y: 0, width: 0, height: 80))
    
    // MARK: - ViewController
    
    func autolayoutSubviews() {
        self.view.addSubview(tableView)
        tableView
            .fix(top: (0.0, self.view), bottom: (0.0, self.view), isRelative: false)
            .fix(left: (0.0, self.view), right: (0.0, self.view))
        
        self.view.addSubview(loadingIndicator)
        loadingIndicator
            .center(toX: self.tableView, toY: self.tableView)
    }
    
    // MARK: - UIViewController
    
    private var cancellable = Set<AnyCancellable>()
    private var stationDetails: StationDetailsModel? {
        didSet {
            tableViewFooter.stationDetails = stationDetails
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.autolayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.loading
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] isLoading in
                self?.tableView.isHidden = isLoading
                isLoading ? self?.loadingIndicator.startAnimating() : self?.loadingIndicator.stopAnimating()
            })
            .store(in: &cancellable)
        self.viewModel.details(for: self.station)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    let alert = UIAlertController(title: "Error \(error.statusCode)".localized, message: error.message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            })
            { [weak self] stationDetails in
                self?.stationDetails = stationDetails
                self?.tableView.reloadData()
            }
            .cancel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        stationDetails = nil
        tableView.reloadData()
        cancellable.forEach { $0.cancel() }
    }
}

extension StationDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationDetails?.evses.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StationDetailsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.evse = stationDetails?.evses[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = UILabel(frame: CGRect(x: 16.0, y: 12.0, width: 350.0, height: 20.0))
        title.text = "Pick a charging point!".localized
        title.textColor = .gray
        
        let view = UIView(frame: .zero)
        view.addSubview(title)
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
}

extension StationDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
}
