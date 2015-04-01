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
    var cardSetNameLabel = UILabel()
    var cardSubSetNameLabel = UILabel()
    var addCardToCollectionButton = UIButton()
    var addCardToWishlistButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TBD"
        
        view.backgroundColor = kBackgroundColor
        navigationController?.toolbarHidden = true
        
        let returnIcon = UIBarButtonItem(image: kNavBarReturnIcon, style: .Plain, target: navigationController, action: "popViewControllerAnimated:")
        returnIcon.tintColor = kToolbarIconColor
        navigationItem.leftBarButtonItem = returnIcon
        
        configureCardImageView()
        configureCardSubjectLabel()
        configureSetNameLabel()
        configureSubSetNameLabel()
        configureAddCardToCollectionButton()
        configureAddCardToWishlistButton()
        
        //configureToolbar()
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.toolbarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        cardImageView.frame = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
        cardSubjectNameLabel.center.x = view.center.x
        
        cardSetNameLabel.center.x = view.center.x
        cardSetNameLabel.center.x = view.center.x
        
        cardSubSetNameLabel.center.x = view.center.x
        cardSubSetNameLabel.center.x = view.center.x
        
        addCardToCollectionButton.center.x = view.center.x + (view.frame.width / 3)
        addCardToCollectionButton.center.y = view.frame.height/1.2
        
        addCardToWishlistButton.center.x = view.center.x - (view.frame.width / 3)
        addCardToWishlistButton.center.y = view.frame.height/1.2
    }
    
    override func viewWillLayoutSubviews() {
        cardImageView.frame = CGRect(x: view.center.x, y: 20, width: view.bounds.width, height: view.bounds.height)
        cardImageView.center.x = view.center.x
        
        cardSubjectNameLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width/1.5, height: view.frame.width/2)
        cardSubjectNameLabel.center.x = view.center.x
        cardSubjectNameLabel.center.y = view.frame.width/2.8
        
        cardSetNameLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width/1.25, height: view.frame.width/1.5)
        cardSetNameLabel.center.x = view.center.x
        cardSetNameLabel.center.y = view.frame.width/2.2
        
        cardSubSetNameLabel.frame = CGRect(x: 0, y: 700, width: view.frame.width/1.25, height: view.frame.width/1.5)
        cardSubSetNameLabel.center.x = view.center.x
        cardSubSetNameLabel.center.y = view.frame.width/1.8
        
        addCardToCollectionButton.center.x = view.center.x + (view.frame.width / 3)
        addCardToCollectionButton.center.y = view.frame.height/1.2
        
        addCardToWishlistButton.center.x = view.center.x - (view.frame.width / 3)
        addCardToWishlistButton.center.y = view.frame.height/1.2
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
        if (baseballCard["nonPlayerName"] as NSString == "N/A") {
            var cardSubjectFirstName = baseballCard["firstName"] as String
            var cardSubjectLastName = baseballCard["lastName"] as String
            cardSubjectNameLabel.text = "\(cardSubjectFirstName)" + " " + "\(cardSubjectLastName)" as String?
        }
        else {
            cardSubjectNameLabel.text = baseballCard["nonPlayerName"] as String?
        }
        
        cardSubjectNameLabel.textAlignment = .Center
        cardSubjectNameLabel.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        cardSubjectNameLabel.textColor = UIColor.darkGrayColor()
        
        self.view.addSubview(cardSubjectNameLabel)
    }
    
    func configureSetNameLabel() {
        var year = baseballCard["year"] as Int
        var set = baseballCard["set"] as String
        cardSetNameLabel.text = "\(year)" + " " + "\(set)" as String?
        cardSetNameLabel.textAlignment = .Center
        cardSetNameLabel.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        cardSetNameLabel.textColor = UIColor.darkGrayColor()
        
        self.view.addSubview(cardSetNameLabel)
    }
    
    func configureSubSetNameLabel() {
        var cardId = baseballCard["cardId"] as String
        var subSet = baseballCard["subSet"] as String
        cardSubSetNameLabel.text = "\(cardId)" + " - " + "\(subSet)" as String?
        cardSubSetNameLabel.textAlignment = .Center
        cardSubSetNameLabel.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        cardSubSetNameLabel.textColor = UIColor.darkGrayColor()
        
        self.view.addSubview(cardSubSetNameLabel)
    }
    
    func configureAddCardToCollectionButton() {
        addCardToCollectionButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        addCardToCollectionButton.frame = CGRectMake(0, 0, 100, 50)
        addCardToCollectionButton.backgroundColor = UIColor.greenColor()
        //addCardToCollectionButton.imageForState(<#state: UIControlState#>)
        addCardToCollectionButton.setTitle("+ Collection", forState: UIControlState.Normal)
        addCardToCollectionButton.addTarget(self, action: "didPushAddCardToCollectionButton", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(addCardToCollectionButton)
        
    }
    
    func configureAddCardToWishlistButton() {
        addCardToWishlistButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        addCardToWishlistButton.frame = CGRectMake(0, 0, 100, 50)
        addCardToWishlistButton.backgroundColor = UIColor.redColor()
        //addCardToWishlistButton.imageForState(<#state: UIControlState#>)
        addCardToWishlistButton.setTitle("+ Wish List", forState: UIControlState.Normal)
        addCardToWishlistButton.addTarget(self, action: "didPushAddCardToWishlistButton", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(addCardToWishlistButton)
        
    }
    
    func didPushAddCardToCollectionButton() {
        let cardAddViewController = WPCardAddViewController()
        cardAddViewController.baseballCard = self.baseballCard as PFObject
        println("\(cardAddViewController.baseballCard)")
        navigationController?.pushViewController(cardAddViewController, animated: true)
    }
    
    func didPushAddCardToWishlistButton() {
        println("Button Tapped")
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
