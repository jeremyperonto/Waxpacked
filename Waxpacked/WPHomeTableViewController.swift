//
//  WPHomeTableViewController.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 2/18/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit

class WPHomeTableViewController: PFQueryTableViewController {

    var segmentedControl: UISegmentedControl = UISegmentedControl(items: ["Following", "All Users"])
    var friendsFilter = Bool()
    
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

        self.title = "Baseball Cards"
        
        configureTableView()
        configureNavigationToolBar()
        
        let logOutIcon = UIBarButtonItem(title: kToolbarLogoutIcon, style: .Plain, target: self, action: "logOut")
        logOutIcon.tintColor = kToolbarIconColor
        navigationItem.leftBarButtonItem = logOutIcon

        let addIcon = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "notImplemented")
        addIcon.tintColor = kToolbarIconColor
        navigationItem.rightBarButtonItem = addIcon
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - UI
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            segmentedControl.frame = CGRectZero
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.tintColor = UIColor.darkGrayColor()
            segmentedControl.addTarget(self, action: "notImplemented", forControlEvents: .ValueChanged)
            view.addSubview(segmentedControl)
        }
        return nil
    }
    
    // MARK: - Table view data source
    
    override func queryForTable() -> PFQuery! {
        let query = PFQuery(className:"CollectionBaseballCard")
        query.orderByAscending("createdAt")
        if (self.objects.count == 0) {
            query.cachePolicy = kPFCachePolicyCacheThenNetwork
        }
        return query
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // MARK - Table View Controller
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kTableViewCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        if (indexPath.row == 1){
            cell.imageView?.image = UIImage(named: "derekjeter_sample")
            cell.textLabel?.text = "Derek Jeter 2014"
        }
        else {
            cell.imageView?.image = UIImage(named: "jackierobinson_sample")
            cell.textLabel?.text = "Jackie Robinson 1958"
        }
        cell.textLabel?.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        cell.backgroundColor = kBackgroundColor
        return cell
    }

}
