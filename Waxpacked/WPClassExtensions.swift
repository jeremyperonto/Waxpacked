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

}