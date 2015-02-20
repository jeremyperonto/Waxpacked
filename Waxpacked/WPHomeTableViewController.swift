//
//  WPHomeTableViewController.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 2/18/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit
import Parse

class WPHomeTableViewController: UITableViewController {

    override init(style: UITableViewStyle) {
        super.init(style: style)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Baseball Cards"
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        navigationController?.hidesBarsOnSwipe = true
        tableView.separatorInset.right = tableView.separatorInset.left
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        view.backgroundColor = kBackgroundColor
        configureNavigationToolBar()
        
        let logOutIcon = UIBarButtonItem(title: kToolbarLogoutIcon, style: .Plain, target: self, action: "logOut")
        logOutIcon.tintColor = kToolbarIconColor
        navigationItem.leftBarButtonItem = logOutIcon

        let addIcon = UIBarButtonItem(title: kToolbarLogoutIcon, style: .Plain, target: self, action: "notImplemented")
        addIcon.tintColor = kToolbarIconColor
        navigationItem.rightBarButtonItem = addIcon
    }
    
    func configureNavigationToolBar() {
        //SystemItem Example
        let searchIcon = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "notImplemented")
        searchIcon.tintColor = kToolbarIconColor
        //FlexibleSpacer Example
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        //Custom Icon Example
        let profileIcon = UIBarButtonItem(image: kToolbarProfileIcon, style: .Plain, target: self, action: "notImplemented")
        profileIcon.tintColor = kToolbarIconColor
        //Custom Text Example
        let usersIcon = UIBarButtonItem(title: kToolbarUsersIcon, style: .Plain, target: self, action: "pushToUsersViewController")
        usersIcon.tintColor = kToolbarIconColor
        
        toolbarItems = [searchIcon, spacer, profileIcon, spacer, usersIcon]
        
        navigationController?.toolbar.barTintColor = kBackgroundColor
        navigationController!.toolbarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    func notImplemented() {
        println("Not implemented")
    }
    
    func logOut() {
        PFUser.logOut()
        navigationController?.popToRootViewControllerAnimated(true)
        navigationController?.navigationBarHidden = true
        navigationController?.toolbarHidden = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        if (indexPath.row == 1){
            cell.imageView?.image = UIImage(named: "derekjeter_sample")
            cell.textLabel?.text = "Derek Jeter 2014"
        }
        else {
            cell.imageView?.image = UIImage(named: "jackierobinson_sample")
            cell.textLabel?.text = "Jackie Robinson 1958"
        }
        cell.textLabel?.font = UIFont(name: kStandardFontName, size: 14) //Change size to constant
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.blueColor() //Change to constant
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

}
