//
//  WPCardAddViewController.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 3/23/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit

class WPCardAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var baseballCard = PFObject(className:"BaseballCard")
    var cardFrontImageView = UIImageView()
    var cardBackImageView = UIImageView()
    var playerFirstNameLabel = UITextField()
    var playerLastNameLabel = UITextField()
    var addCardToCollectionButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add Card"
        
        view.backgroundColor = kBackgroundColor
        
        viewDidLayoutSubviews()
        configureCardFrontImageView()
        configureCardBackImageView()
        configurePlayerFirstNameLabel()
        configurePlayerLastNameLabel()
        configureAddCardToCollectionButton()
        configureAutoPopulatedCardInfo()
    }
    
    override func viewDidLayoutSubviews() {
        cardFrontImageView.frame = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
        cardFrontImageView.center.x = view.center.x - (view.frame.width / 3)
        cardFrontImageView.center.y = view.frame.height/3
        
        cardBackImageView.frame = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
        cardBackImageView.center.x = view.center.x + (view.frame.width / 3)
        cardBackImageView.center.y = view.frame.height/3
        
        playerFirstNameLabel.center.x = view.center.x - (view.frame.width / 5)
        playerFirstNameLabel.center.y = view.frame.height/2
        
        playerLastNameLabel.center.x = view.center.x + (view.frame.width / 5)
        playerLastNameLabel.center.y = view.frame.height/2
        
        addCardToCollectionButton.center.x = view.center.x
        addCardToCollectionButton.center.y = view.frame.height/1.2
    }
    
    func configureCardFrontImageView() {
        let defaultCardImageView = kProfileDefaultProfileImage
        cardFrontImageView.frame = CGRectMake(0, 0, view.bounds.width / 8, view.bounds.height / 8)
        cardFrontImageView.center.x = view.center.x
        cardFrontImageView.image = defaultCardImageView
        cardFrontImageView.contentMode = .ScaleAspectFit
        
        self.view.addSubview(cardFrontImageView)
    }
    
    func configureCardBackImageView() {
        let defaultCardImageView = kProfileDefaultProfileImage
        cardBackImageView.frame = CGRectMake(0, 0, view.bounds.width / 8, view.bounds.height / 8)
        cardBackImageView.center.x = view.center.x
        cardBackImageView.image = defaultCardImageView
        cardBackImageView.contentMode = .ScaleAspectFit
        
        self.view.addSubview(cardBackImageView)
    }
    
    func configurePlayerFirstNameLabel() {
     
        playerFirstNameLabel.frame = CGRectZero
        playerFirstNameLabel.layer.borderWidth = 1.0
        playerFirstNameLabel.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        playerFirstNameLabel.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont(name: kStandardFontName, size: kStandardFontSize)!])
        playerFirstNameLabel.layer.borderColor = UIColor.darkGrayColor().CGColor
        playerFirstNameLabel.layer.cornerRadius = 5.0
        playerFirstNameLabel.textColor = UIColor.darkGrayColor()
        playerFirstNameLabel.keyboardType = UIKeyboardType.Default
        playerFirstNameLabel.textAlignment = .Left
        playerFirstNameLabel.sizeToFit()
        
        self.view.addSubview(playerFirstNameLabel)
    }
    
    func configurePlayerLastNameLabel() {
        
        playerLastNameLabel.frame = CGRectZero
        playerLastNameLabel.layer.borderWidth = 1.0
        playerLastNameLabel.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        playerLastNameLabel.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont(name: kStandardFontName, size: kStandardFontSize)!])
        playerLastNameLabel.layer.borderColor = UIColor.darkGrayColor().CGColor
        playerLastNameLabel.layer.cornerRadius = 5.0
        playerLastNameLabel.textColor = UIColor.darkGrayColor()
        playerLastNameLabel.keyboardType = UIKeyboardType.Default
        playerLastNameLabel.textAlignment = .Left
        playerLastNameLabel.sizeToFit()
        
        self.view.addSubview(playerLastNameLabel)
    }
    
    func configureAutoPopulatedCardInfo() {
    if (baseballCard != nil) {
        playerFirstNameLabel.text = baseballCard["firstName"] as String
        playerLastNameLabel.text = baseballCard["lastName"] as String
    } else {
        println("No card associated")
    }
    }
    
    func configureAddCardToCollectionButton() {
        addCardToCollectionButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        addCardToCollectionButton.frame = CGRectMake(0, 0, 100, 50)
        addCardToCollectionButton.backgroundColor = UIColor.redColor()
        //addCardToCollectionButton.imageForState(<#state: UIControlState#>)
        addCardToCollectionButton.setTitle("Share →", forState: UIControlState.Normal)
        addCardToCollectionButton.addTarget(self, action: "didPushAddCardToCollectionButton", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(addCardToCollectionButton)
        
    }
    
    func didPushAddCardToCollectionButton() {

        //ADD IMAGE & ALERT FOR NO ADDED IMAGE, POP TO HOME VC

        if (baseballCard != nil) {
            var collectionBaseballCard = PFObject(className:"CollectionBaseballCard")
            collectionBaseballCard["firstName"] = playerFirstNameLabel.text
            collectionBaseballCard["lastName"] = playerLastNameLabel.text
            
            // Add a relation between the Collection Card and Read-only Card
            collectionBaseballCard["parent"] = PFObject(withoutDataWithClassName:"BaseballCard", objectId:"\(baseballCard.objectId)")
            
            // Save both myPost and myComment
            //baseballCard.saveInBackground()
            
            collectionBaseballCard.saveInBackgroundWithBlock {
                (success: Bool, error: NSError!) -> Void in
                if (success) {
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                }
            }
        } else {
            println("Cancelled")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
