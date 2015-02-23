//
//  WPUsersTableViewController.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 2/21/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit

class WPUsersTableViewController: PFQueryTableViewController {

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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func queryForTable() -> PFQuery! {
        let query = PFUser.query()
        query.whereKey("username", notEqualTo: PFUser.currentUser().username)
        query.orderByAscending("username")
        
        //if network cannot find any data, go to cached data
        if (self.objects.count == 0){
            query.cachePolicy = kPFCachePolicyCacheThenNetwork
        }
        
        return query
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

}
