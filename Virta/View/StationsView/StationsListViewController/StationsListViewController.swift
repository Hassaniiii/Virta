//
//  MainViewController.swift
//  Virta
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit
import Combine

final class StationsListViewController: UIViewController, ViewController {
    
    // MARK: - Injected
    
    var viewModel: StationsListViewModel!
    var onStationTapped = PassthroughSubject<StationsListModel, Never>()
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.registerClass(StationsListTableViewCell.self)
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.separatorStyle = .none
        view.allowsMultipleSelection = false
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
    private var stations: [StationsListModel] = []
    private var page: Int = Constants.APIInitialPage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.autolayoutSubviews()
        self.viewModel.loading
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] isLoading in
                self?.tableView.isHidden = isLoading
                isLoading ? self?.loadingIndicator.startAnimating() : self?.loadingIndicator.stopAnimating()
            })
            .store(in: &cancellable)
        self.viewModel.locationService.location
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.page = Constants.APIInitialPage
                self?.fetchStations()
            }
            .store(in: &cancellable)
        self.fetchStations()
    }
    
    deinit {
        cancellable.forEach { $0.cancel() }
    }
    
    private func fetchStations() {
        self.viewModel.stations(at: page)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    let alert = UIAlertController(title: "Error \(error.statusCode)".localized, message: error.message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            })
            { [weak self] stations in
                stations.forEach {
                    if !(self?.stations.contains($0) ?? false) { self?.stations.append($0) }
                }
                self?.tableView.reloadData()
            }
            .store(in: &cancellable)
    }
}

extension StationsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as StationsListTableViewCell
        cell.station = stations[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /// we could implement pagination, but then we need to have appropriate scenario
        /// for sorting the results, since that would be weird to change items' ordering
        /// on the runtime.
        if stations.count - indexPath.row <= Constants.TableItemsThreshold {
            self.page += 1
//            self.fetchStations()
        }
    }
}

extension StationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 + ((CGFloat(stations[indexPath.row].evses.count) / 3.0) + 1) * 30
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onStationTapped.send(stations[indexPath.row])
    }
}

