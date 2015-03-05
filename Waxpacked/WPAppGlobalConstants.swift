//
//  WPAppGlobalConstants.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 2/19/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import Foundation

let kLoginLogo = "MLBLOGO"
let kSignUpLogo = "MLBLOGO"

let kTitleFontName = "HelveticaNeue-Thin"
let kTitleFontSize:CGFloat = 25

let kBackgroundColor = UIColor(red: 0.999000, green: 0.999000, blue: 0.999000, alpha: 1)
let kStandardFontName = "HelveticaNeue-Thin"
let kStandardFontSize:CGFloat = 20

//Parse
let kParseClassNameProfileImage = "profileImage"

//Navigation
let kToolbarLogoutIcon = "Log Out"
let kToolbarIconColor = UIColor.darkGrayColor()
let kToolbarProfileIcon = UIImage(named: "Profile")
let kToolbarHomeIcon = UIImage(named: "Home")
let kToolbarUsersIcon = "Users"
let kToolbarFriendsIcon = "Friends"

let kNavBarReturnIcon = UIImage(named: "Return")

//TableViewCell
let kTableViewCellIdentifier = "Cell"

//Profile
let kProfileDefaultProfileImage = UIImage(named: "defaultProfileImage")
let kProfilePhotoDimensions = CGSizeMake(300,300)

enum kProfileMetros: String {
    case
    NewYork = "New York, New York",
    LosAngeles = "Los Angeles, California",
    Chicago = "Chicago, Illinois",
    Houston = "Houston, Texas",
    SanDiego = "San Diego, California",
    Dallas = "Dallas, Texas",
    Austin = "Austin, Texas",
    Memphis = "Memphis, Tennessee",
    Boston = "Boston, Massachusetts",
    Seattle = "Seattle, Washington",
    Denver = "Denver, Colorado",
    Washington = "Washington, District of Columbia",
    Atlanta = "Atlanta, Georgia"
    
    static let allValues =
    [NewYork,
        LosAngeles,
        Chicago,
        Houston ,
        SanDiego ,
        Dallas,
        Austin,
        Memphis,
        Boston,
        Seattle,
        Denver,
        Washington,
        Atlanta]
}