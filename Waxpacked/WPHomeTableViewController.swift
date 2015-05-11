//
//  WPHomeTableViewController.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 2/18/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit

class WPHomeTableViewController: PFQueryTableViewController {
    
    var homeTableViewSegmentedControl: UISegmentedControl = UISegmentedControl(items: ["Following", "All Users"])
    
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
        navigationController?.toolbarHidden = false
        
        let logOutIcon = UIBarButtonItem(title: kToolbarLogoutIcon, style: .Plain, target: self, action: "logOut")
        logOutIcon.tintColor = kToolbarIconColor
        navigationItem.leftBarButtonItem = logOutIcon

        let addIcon = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "notImplemented")
        addIcon.tintColor = kToolbarIconColor
        navigationItem.rightBarButtonItem = addIcon
        
        tableView.registerClass(WPCardSearchTableViewCell.self, forCellReuseIdentifier: kTableViewCellIdentifier)
        tableView.separatorInset.right = tableView.separatorInset.left
        tableView.tableFooterView = UIView(frame: CGRectZero)
        view.backgroundColor = kBackgroundColor
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.toolbarHidden = false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    //MARK - UI
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            homeTableViewSegmentedControl.frame = CGRectZero
            homeTableViewSegmentedControl.selectedSegmentIndex = 0
            homeTableViewSegmentedControl.tintColor = UIColor.darkGrayColor()
            homeTableViewSegmentedControl.addTarget(self, action: "notImplemented", forControlEvents: .ValueChanged)
            view.addSubview(homeTableViewSegmentedControl)
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 32
        }
        return 0.1
    }
    
    // MARK - Table View Controller
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> WPCardSearchTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kTableViewCellIdentifier, forIndexPath: indexPath) as! WPCardSearchTableViewCell
        
        cell.imageView.hidden = true
        cell.textLabel?.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        cell.backgroundColor = kBackgroundColor
        cell.textLabel?.text
        
        
        
        if (object["nonPlayerName"] != nil && object["firstName"] != nil && object["lastName"] != nil){
        
            
//            var cardFrontImage = object["baseballCardFrontImage"] as! UIImage
//            (cell.viewWithTag(1) as! UIImage) = cardFrontImage
            
            if (object["nonPlayerName"] as! NSString == "N/A") {
                var cardSubjectFirstName = object["firstName"] as! String
                var cardSubjectLastName = object["lastName"] as! String
                (cell.viewWithTag(2) as! UILabel).text = "\(cardSubjectFirstName)" + " " + "\(cardSubjectLastName)"
                (cell.viewWithTag(2) as! UILabel).sizeToFit()
            }
            else {
                (cell.viewWithTag(2) as! UILabel).text = object["nonPlayerName"] as? String
                (cell.viewWithTag(2) as! UILabel).sizeToFit()
            }
            
            //cell.textLabel?.text
            var year = object["year"] as! Int
            var set = object["set"] as! String
            (cell.viewWithTag(3) as! UILabel).text = "\(year)" + " " + "\(set)"
            (cell.viewWithTag(3) as! UILabel).sizeToFit()
            
            //cell.textLabel?.text
            var cardId = object["cardId"] as! String
            var subSet = object["subSet"] as! String
            (cell.viewWithTag(4) as! UILabel).text = "\(cardId)" + " - " + "\(subSet)"
            (cell.viewWithTag(4) as! UILabel).sizeToFit()
        }
        else {
            println("No Name")
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedIndexPath = tableView.indexPathForSelectedRow()
        let cardInfoViewController = WPCardInfoViewController()
        cardInfoViewController.baseballCard = objectAtIndexPath(selectedIndexPath) as PFObject
        navigationController?.pushViewController(cardInfoViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

}
