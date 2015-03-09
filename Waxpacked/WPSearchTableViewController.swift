//
//  WPSearchTableViewController.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 3/4/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit

class WPSearchTableViewController: PFQueryTableViewController, UISearchBarDelegate {

    var searchBar: UISearchBar!
    var searchInProgress = Bool()
    
    override init!(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
        pullToRefreshEnabled = true
        paginationEnabled = true
        objectsPerPage = 25
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationToolBar()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func queryForTable() -> PFQuery! {
        let query = PFQuery(className:"BaseballCard")
        if (searchInProgress) {
            query.whereKey("searchQuery", containsString: searchBar.text)
        }
        query.orderByAscending("searchQuery")
        
        if (self.objects.count == 0) {
            query.cachePolicy = kPFCachePolicyCacheThenNetwork
        }
        return query
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            searchBar = UISearchBar(frame: CGRectMake(0, 0, tableView.frame.size.width, 0))
            searchBar.barTintColor = kBackgroundColor
            searchBar.showsCancelButton = true
            searchBar.showsSearchResultsButton = false
            searchBar.tintColor = UIColor.darkGrayColor()
            searchBar.delegate = self
            return searchBar
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 32
        }
        return 0.1
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchInProgress = true
        loadObjects()
        searchInProgress = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchInProgress = false
        loadObjects()
        searchBar.resignFirstResponder()
    }
}
