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
        view.backgroundColor = UIColor.blueColor() //Change to constant
        configureNavigationToolBar()
        
        let logOutIcon = UIBarButtonItem(title: kToolbarLogoutIcon, style: .Plain, target: self, action: "logOut")
        logOutIcon.tintColor = UIColor.blueColor() //Change to constant
        navigationItem.leftBarButtonItem = logOutIcon

        let addIcon = UIBarButtonItem(title: kToolbarLogoutIcon, style: .Plain, target: self, action: "notImplemented")
        addIcon.tintColor = UIColor.blueColor() //Change to constant
        navigationItem.rightBarButtonItem = addIcon
    }
    
    func configureNavigationToolBar() {
        //SystemItem Example
        let searchIcon = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "notImplemented")
        searchIcon.tintColor = UIColor.blueColor() //Change to constant
        //FlexibleSpacer Example
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        //Custom Icon Example
        let profileIcon = UIBarButtonItem(image: UIImage(named: "Profile"), style: .Plain, target: self, action: "notImplemented") //Change image to constant
        profileIcon.tintColor = UIColor.blueColor() //Change to constant
        //Custom Text Example
        let usersIcon = UIBarButtonItem(title: kToolbarUsersIcon, style: .Plain, target: self, action: "pushToUsersViewController")
        usersIcon.tintColor = UIColor.blueColor() //Change to constant
        
        toolbarItems = [searchIcon, spacer, profileIcon, spacer, usersIcon]
        
        navigationController?.toolbar.barTintColor = UIColor.blueColor() //Change to constant
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
    
//    func logOut() {
//        PFUser.logout()
//        navigationController?.popToRootViewControllerAnimated(true)
//        navigationController?.navigationBarHidden = true
//        navigationController?.toolbarHidden = true
//    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
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
