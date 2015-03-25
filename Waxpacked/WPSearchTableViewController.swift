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
        objectsPerPage = 100
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationToolBar()

        tableView.registerClass(WPCardSearchTableViewCell.self, forCellReuseIdentifier: kTableViewCellIdentifier)
        tableView.separatorInset.right = tableView.separatorInset.left
        tableView.tableFooterView = UIView(frame: CGRectZero)
        view.backgroundColor = kBackgroundColor
        
    }

    // MARK: - Table view data source


    override func queryForTable() -> PFQuery! {
        let query = PFQuery(className:"BaseballCard")
        
        if (searchInProgress) {

            query.whereKey("searchQuery", containsString: searchBar.text)
            
//            let cardSearchCheckOne = PFQuery(className:"BaseballCard")
//            cardSearchCheckOne.whereKey("firstName", containsString: searchBar.text)
//            let cardSearchCheckTwo = PFQuery(className:"BaseballCard")
//            cardSearchCheckTwo.whereKey("cardId", containsString: searchBar.text)
//            let cardSearchCheckThree = PFQuery(className:"BaseballCard")
//            cardSearchCheckThree.whereKey("nonPlayerName", containsString: searchBar.text)
//            
//            let cardSearchQuery = PFQuery.orQueryWithSubqueries([cardSearchCheckOne, cardSearchCheckTwo, cardSearchCheckThree])
//            cardSearchQuery.findObjectsInBackgroundWithBlock {
//                (results: [AnyObject]!, error: NSError!) -> Void in
//                if error == nil {
//                    // results contains players with lots of wins or only a few wins.
//                }
//            }
        }
        query.orderByAscending("objectId")
        
        if (self.objects.count == 0) {
            query.cachePolicy = kPFCachePolicyCacheThenNetwork
        }
        return query
    }

    //MARK - Search
    
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
    
    // MARK - Table View Controller
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> WPCardSearchTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as WPCardSearchTableViewCell
        cell.imageView.hidden = true
        
        cell.textLabel?.text
        if (object["nonPlayerName"] as NSString == "N/A") {
            var cardSubjectFirstName = object["firstName"] as String
            var cardSubjectLastName = object["lastName"] as String
            (cell.viewWithTag(2) as UILabel).text = "\(cardSubjectFirstName)" + " " + "\(cardSubjectLastName)"
            (cell.viewWithTag(2) as UILabel).sizeToFit()
        }
        else {
            (cell.viewWithTag(2) as UILabel).text = object["nonPlayerName"] as? String
            (cell.viewWithTag(2) as UILabel).sizeToFit()
        }
        
        cell.textLabel?.text
        var year = object["year"] as Int
        var set = object["set"] as String
        (cell.viewWithTag(3) as UILabel).text = "\(year)" + " " + "\(set)"
        (cell.viewWithTag(3) as UILabel).sizeToFit()

        cell.textLabel?.text
        var cardId = object["cardId"] as String
        var subSet = object["subSet"] as String
        (cell.viewWithTag(4) as UILabel).text = "\(cardId)" + " - " + "\(subSet)"
        (cell.viewWithTag(4) as UILabel).sizeToFit()

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
