//
//  WPCardInfoViewController.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 3/13/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit

class WPCardInfoViewController: UIViewController {

    var cardImageView = UIImageView()
    var cardSubjectNameLabel = UILabel()
    var setNameLabel = UILabel()
    var subSetNameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Title TBD"
        
        view.backgroundColor = kBackgroundColor
        
        let returnIcon = UIBarButtonItem(image: kNavBarReturnIcon, style: .Plain, target: navigationController, action: "popViewControllerAnimated:")
        returnIcon.tintColor = kToolbarIconColor
        navigationItem.leftBarButtonItem = returnIcon
        
        configureCardImageView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureToolbar() {
        
    }
    
    func configureCardImageView() {
        let defaultCardImageView = kProfileDefaultProfileImage
        cardImageView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        cardImageView.center.x = view.center.x
        cardImageView.image = defaultCardImageView
        cardImageView.contentMode = .ScaleAspectFit
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
