//
//  SearchResultsTableViewController.swift
//  iTunes-Search
//
//  Created by Alexander Supe on 1/14/20.
//  Copyright © 2020 Alexander Supe. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segment: UISegmentedControl!
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchResultsController.searchResults[indexPath.row].title
        cell.detailTextLabel?.text = searchResultsController.searchResults[indexPath.row].creator
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        var resultType: ResultType
        
        switch segment.selectedSegmentIndex {
        case 0: resultType = .software
        case 1: resultType = .musicTrack
        default: resultType = .movie
        }
        
        searchResultsController.performSearch(searchTerm: text, resultType: resultType) {
            if $0 != nil { print(String(describing: $0)) }
            else { DispatchQueue.main.async { self.tableView.reloadData() } }
        }
    }
}
