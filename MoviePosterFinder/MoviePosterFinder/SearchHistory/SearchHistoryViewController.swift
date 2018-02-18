//
//  SearchHistoryViewController.swift
//  MoviePosterFinder
//
//  Created by Serhii Palash on 18/02/2018.
//  Copyright © 2018 Serhii Palash. All rights reserved.
//

import UIKit

class SearchHistoryViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    fileprivate let searchHistoryTableViewCellIdentifier = "SearchHistoryTableViewCell"
    private let searchDateProvider = SearchDateProvider()
    private var searchDates: [SearchDate]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchDateProvider.getAll(completion: { [weak self] (dates) in
            self?.searchDates = dates
            self?.tableView.reloadData()
        })
    }
    
}

// MARK: - UITableViewDataSource

extension SearchHistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchDates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: searchHistoryTableViewCellIdentifier, for: indexPath)
    }
}

// MARK: - UITableViewDelegate

extension SearchHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? SearchHistoryTableViewCell,
            let searchDate = searchDates?[indexPath.row] {
            cell.searchDate = searchDate
        }
    }
}
