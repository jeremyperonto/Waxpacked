//
//  WPClassExtensions.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 2/20/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import Foundation

extension UIViewController {
    func logOut(){
        PFUser.logOut()
        navigationController?.popToRootViewControllerAnimated(true)
        navigationController?.navigationBarHidden = true
        navigationController?.toolbarHidden = true
    }
    
    func configureNavigationToolBar() {
        //SystemItem Example
        let searchIcon = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "notImplemented")
        searchIcon.tintColor = kToolbarIconColor
        //FlexibleSpacer Example
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        //Custom Icon Example
        let profileIcon = UIBarButtonItem(image: kToolbarProfileIcon, style: .Plain, target: self, action: "pushToMyProfileViewController")
        profileIcon.tintColor = kToolbarIconColor
        //Custom Text Example
        let usersIcon = UIBarButtonItem(title: kToolbarUsersIcon, style: .Plain, target: self, action: "pushToUsersViewController")
        usersIcon.tintColor = kToolbarIconColor
        let friendsIcon = UIBarButtonItem(title: kToolbarUsersIcon, style: .Plain, target: self, action: "pushToFriendsViewController")
        friendsIcon.tintColor = kToolbarIconColor
        
        toolbarItems = [searchIcon, spacer, profileIcon, spacer, usersIcon]
        
        navigationController?.toolbar.barTintColor = kBackgroundColor
        navigationController!.toolbarHidden = false
}

    public override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if (event.subtype == UIEventSubtype.MotionShake) {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
            if (viewControllers.count > 2) {
                navigationController?.popToViewController(viewControllers[viewControllers.count - 2],
                    animated: true)
            }
        }
    }
    
    func notImplemented(){
        println("Not Implemented")
    }
}

extension UITableViewController {
    func configureTableView() {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: kTableViewCellIdentifier)
        tableView.separatorInset.right = tableView.separatorInset.left
        tableView.tableFooterView = UIView(frame: CGRectZero)
        view.backgroundColor = kBackgroundColor
    }
    
    func addPullToRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl!.tintColor = UIColor.whiteColor()
        refreshControl?.addTarget(self, action: "loadObjects", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!)
    }
}