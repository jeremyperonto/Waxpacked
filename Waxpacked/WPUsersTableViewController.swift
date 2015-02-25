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
        
        title = "Users"
        
        tableView.registerClass(WPUserTableViewCell.self, forCellReuseIdentifier: kTableViewCellIdentifier)
        tableView.separatorInset.right = tableView.separatorInset.left
        tableView.tableFooterView = UIView(frame: CGRectZero)
        view.backgroundColor = kBackgroundColor
        
        let returnIcon = UIBarButtonItem(image: kNavBarReturnIcon, style: .Plain, target: navigationController, action: "popViewControllerAnimated:")
        returnIcon.tintColor = kToolbarIconColor
        navigationItem.leftBarButtonItem = returnIcon
        
    }
    
    override func queryForTable() -> PFQuery! {
        let query = PFUser.query()
        query.whereKey("username", notEqualTo: PFUser.currentUser().username)
        query.orderByAscending("username")
        
        //if network cannot find any data, go to cached (local disk data)
        if (self.objects.count == 0){
            query.cachePolicy = kPFCachePolicyCacheThenNetwork
        }
        
        return query
    }
    
    //MARK - Search
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let searchBar = UISearchBar(frame: CGRectMake(0, 0, tableView.frame.size.width, 0))
            searchBar.barTintColor = kBackgroundColor
            return searchBar
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        }
        return 0.1
    }
    
    
    // MARK - Table View Controller
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> WPUserTableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as WPUserTableViewCell
        cell.imageView.hidden = true
        (cell.viewWithTag(1) as PFImageView).image = kProfileDefaultProfileImage
        dispatch_async(dispatch_get_main_queue(),{
            
            if let profileImageData = object["profileImage"] as? PFFile {
                cell.imageView.file = profileImageData
                (cell.viewWithTag(1) as PFImageView).file = cell.imageView.file
            }
            cell.textLabel?.text
            (cell.viewWithTag(2) as UILabel).text = object["username"] as? String
            (cell.viewWithTag(2) as UILabel).sizeToFit()
            
        });
        //cell.updateConstraints()
        return cell
    }
    
    override func objectAtIndexPath(indexPath: NSIndexPath!) -> PFObject! {
        var obj : PFObject? = nil
        if(indexPath.row < self.objects.count){
            obj = self.objects[indexPath.row] as? PFObject
        }
        return obj
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedIndexPath = tableView.indexPathForSelectedRow()
        let profileViewController = WPProfileViewController()
        profileViewController.profileUser = objectAtIndexPath(selectedIndexPath) as PFUser
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
