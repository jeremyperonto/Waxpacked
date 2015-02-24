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
        textKey = "username"
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
        
        tableView.registerClass(PFTableViewCell.self, forCellReuseIdentifier: kTableViewCellIdentifier)
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
        
        //if network cannot find any data, go to cached data
        if (self.objects.count == 0){
            query.cachePolicy = kPFCachePolicyCacheThenNetwork
        }
        
        return query
    }
    
    // MARK - Navigation
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject) -> PFTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as PFTableViewCell
        cell.textLabel?.text = object["username"] as? String
        
        if let profileImage = object["profileImage"] as? PFFile {
            cell.imageView.file = profileImage
        }
        else {
            cell.imageView.image = kProfileDefaultProfileImage
        }
        
        cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width / 2;
        cell.imageView.clipsToBounds = true
        cell.imageView.layer.borderWidth = 3.0
        cell.imageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        cell.textLabel?.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = kBackgroundColor
        
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
        return 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
