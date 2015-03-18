//
//  WPCardInfoViewController.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 3/13/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit

class WPCardInfoViewController: UIViewController {

    var baseballCard = PFObject(className:"BaseballCard")
    var cardImageView = UIImageView()
    var cardSubjectNameLabel = UILabel()
    var setNameLabel = UILabel()
    var subSetNameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TBD"
        
        view.backgroundColor = kBackgroundColor
        
        let returnIcon = UIBarButtonItem(image: kNavBarReturnIcon, style: .Plain, target: navigationController, action: "popViewControllerAnimated:")
        returnIcon.tintColor = kToolbarIconColor
        navigationItem.leftBarButtonItem = returnIcon
        
        configureCardImageView()
        configureCardSubjectLabel()
        
        //configureToolbar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureToolbar() {
        //navigationController?.hidesBarsOnSwipe = false
        //navigationController?.hidesBarsOnTap = true
        //navigationController?.toolbarHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        cardImageView.frame = CGRect(x: view.center.x, y: 20, width: view.bounds.width, height: view.bounds.height)
        cardImageView.center.x = view.center.x
        
        cardSubjectNameLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width/1.5, height: view.frame.width/2)
        cardSubjectNameLabel.center.x = view.center.x
        cardSubjectNameLabel.center.y = view.frame.width/2.8
        
//        setNameLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width/1.25, height: view.frame.width/1.5)
//        setNameLabel.center.x = view.center.x
//        setNameLabel.center.y = view.frame.width/2.2
//        
//        subSetNameLabel.frame = CGRect(x: 0, y: 70, width: view.frame.width/1.25, height: view.frame.width/1.5)
//        subSetNameLabel.center.x = view.center.x - 100
//        subSetNameLabel.center.y = view.frame.width/1.8
        
    }
    
    override func viewDidLayoutSubviews() {
        cardImageView.frame = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
        cardSubjectNameLabel.center.x = view.center.x
        setNameLabel.center.x = view.center.x
        subSetNameLabel.center.x = view.center.x
    }
    
    func configureCardImageView() {
        let defaultCardImageView = kProfileDefaultProfileImage
        cardImageView.frame = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
        cardImageView.center.x = view.center.x
        cardImageView.image = defaultCardImageView
        cardImageView.contentMode = .ScaleAspectFit
        
        self.view.addSubview(cardImageView)
    }
    
    func configureCardSubjectLabel() {
        cardSubjectNameLabel.text = baseballCard["firstName"] as String?
        cardSubjectNameLabel.textAlignment = .Center
        cardSubjectNameLabel.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        cardSubjectNameLabel.textColor = UIColor.darkGrayColor()
        
        self.view.addSubview(cardSubjectNameLabel)
    }
    
    func configureSetNameLabel() {
        
    }
    
    func configureSubSetNameLabel() {
        
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
