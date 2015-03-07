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
        let homeIcon = UIBarButtonItem(image: kToolbarHomeIcon, style:.Plain, target: self, action: "pushToHomeViewController")
        homeIcon.tintColor = kToolbarIconColor
        //SystemItem Example
        let searchIcon = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "pushToSearchTableViewController")
        searchIcon.tintColor = kToolbarIconColor
        //FlexibleSpacer Example
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        //Custom Icon Example
        let profileIcon = UIBarButtonItem(image: kToolbarProfileIcon, style: .Plain, target: self, action: "pushToMyProfileViewController")
        profileIcon.tintColor = kToolbarIconColor
        //Custom Text Example
        let usersIcon = UIBarButtonItem(title: kToolbarUsersIcon, style: .Plain, target: self, action: "pushToUsersViewController")
        usersIcon.tintColor = kToolbarIconColor
        let friendsIcon = UIBarButtonItem(title: kToolbarFriendsIcon, style: .Plain, target: self, action: "pushToFriendsViewController")
        friendsIcon.tintColor = kToolbarIconColor
        
        toolbarItems = [homeIcon, spacer, searchIcon, spacer, profileIcon, spacer, friendsIcon, spacer, usersIcon]
        
        navigationController?.toolbar.barTintColor = UIColor.lightGrayColor()
        navigationController!.toolbarHidden = false
}
    
 
    // MARK: - Navigation
    
    func pushToHomeViewController() {
        let pushToHomeViewController = WPHomeTableViewController(style: .Plain)
        navigationController?.pushViewController(pushToHomeViewController, animated: false)
    }
    
    func pushToSearchTableViewController() {
        let pushToSearchTableViewController = WPSearchTableViewController(style: .Plain, className: "cards")
        navigationController?.pushViewController(pushToSearchTableViewController, animated: false)
    }
    
    func pushToMyProfileViewController() {
        let myProfileViewController = WPProfileViewController()
        myProfileViewController.friendStatus = 0
        myProfileViewController.profileUser = PFUser.currentUser()
        navigationController?.pushViewController(myProfileViewController, animated: false)
    }
    
    func pushToUsersViewController() {
        let usersTableViewController = WPUsersTableViewController(style: .Plain, className: "users")
        usersTableViewController.friendsFilter = false
        navigationController!.pushViewController(usersTableViewController, animated: true)
    }
    
    func pushToFriendsViewController() {
        let usersTableViewController = WPUsersTableViewController(style: .Plain, className: "users")
        usersTableViewController.friendsFilter = true
        navigationController!.pushViewController(usersTableViewController, animated: true)
    }
    
    
    
    
    
    //MARK: - Motion Events

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
        refreshControl!.tintColor = UIColor.darkGrayColor()
        refreshControl?.addTarget(self, action: "loadObjects", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!)
    }
}