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
    let cardSubjectType = UISegmentedControl(items:["Player"," Non-Player"])
    var cardFrontImageView = UIImageView()
    var cardBackImageView = UIImageView()
    var userCaptionTextField = UITextField()
    var playerFirstNameTextField = UITextField()
    var playerLastNameTextField = UITextField()
    var nonPlayerNameTextField = UITextField()
    var cardIdTextField = UITextField()
    var notesTextField = UITextField()
    var setTextField = UITextField()
    var subSetTextField = UITextField()
    var yearTextField = UITextField()
    var rcSwitch = UISwitch()
    var spSwitch = UISwitch()
    
    var addCardToCollectionButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add Card"
        
        view.backgroundColor = kBackgroundColor
        cardSubjectType.selectedSegmentIndex = 0
        
        viewDidLayoutSubviews()
        configureCardFrontImageView()
        configureCardBackImageView()
        configureUserCaptionTextField()
        configurePlayerFirstNameTextField()
        configurePlayerLastNameTextField()
        configureCardIdTextField()
        configureAddCardToCollectionButton()
        configureAutoPopulatedCardInfo()
        configurePlayerFirstNameTextField()
        configurePlayerLastNameTextField()
        configureNonPlayerNameTextField()
        configureCardIdTextField()
        configureNotesTextField()
        configureRcSwitch()
        configureSetTextField()
        configureSpSwitch()
        configureSubSetTextField()
        configureYearTextField()
    }
    
    override func viewDidLayoutSubviews() {
        cardFrontImageView.frame = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
        cardFrontImageView.center.x = view.center.x - (view.frame.width / 3)
        cardFrontImageView.center.y = view.frame.height/3
        
        cardBackImageView.frame = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
        cardBackImageView.center.x = view.center.x + (view.frame.width / 3)
        cardBackImageView.center.y = view.frame.height/3
        
        playerFirstNameTextField.center.x = view.center.x - (view.frame.width / 5)
        playerFirstNameTextField.center.y = view.frame.height/2
        
        playerLastNameTextField.center.x = view.center.x + (view.frame.width / 5)
        playerLastNameTextField.center.y = view.frame.height/2
        
        addCardToCollectionButton.center.x = view.center.x
        addCardToCollectionButton.center.y = view.frame.height/1.2
    }
    
    func didSelectCardSubjectTypeSegmentedControl(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex
        {
        case 0:
            notImplemented()
        default:
            notImplemented()
        }
        notImplemented()
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
    
    func configureUserCaptionTextField() {
        userCaptionTextField.frame = CGRectZero
        userCaptionTextField.layer.borderWidth = 1.0
        userCaptionTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        userCaptionTextField.attributedPlaceholder = NSAttributedString(string: "Tell the world about your card", attributes: [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont(name: kStandardFontName, size: kStandardFontSize)!])
        userCaptionTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        userCaptionTextField.layer.cornerRadius = 5.0
        userCaptionTextField.textColor = UIColor.darkGrayColor()
        userCaptionTextField.keyboardType = UIKeyboardType.Default
        userCaptionTextField.textAlignment = .Left
        userCaptionTextField.sizeToFit()
        
        self.view.addSubview(playerFirstNameTextField)
    }
    
    func configurePlayerFirstNameTextField() {
        playerFirstNameTextField.frame = CGRectZero
        playerFirstNameTextField.layer.borderWidth = 1.0
        playerFirstNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        playerFirstNameTextField.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont(name: kStandardFontName, size: kStandardFontSize)!])
        playerFirstNameTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        playerFirstNameTextField.layer.cornerRadius = 5.0
        playerFirstNameTextField.textColor = UIColor.darkGrayColor()
        playerFirstNameTextField.keyboardType = UIKeyboardType.Default
        playerFirstNameTextField.textAlignment = .Left
        playerFirstNameTextField.sizeToFit()
        
        self.view.addSubview(playerFirstNameTextField)
    }
    
    func configurePlayerLastNameTextField() {
        
        playerLastNameTextField.frame = CGRectZero
        playerLastNameTextField.layer.borderWidth = 1.0
        playerLastNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        playerLastNameTextField.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont(name: kStandardFontName, size: kStandardFontSize)!])
        playerLastNameTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        playerLastNameTextField.layer.cornerRadius = 5.0
        playerLastNameTextField.textColor = UIColor.darkGrayColor()
        playerLastNameTextField.keyboardType = UIKeyboardType.Default
        playerLastNameTextField.textAlignment = .Left
        playerLastNameTextField.sizeToFit()
        
        self.view.addSubview(playerLastNameTextField)
    }
    
    func configureNonPlayerNameTextField() {
        
        nonPlayerNameTextField.frame = CGRectZero
        nonPlayerNameTextField.layer.borderWidth = 1.0
        nonPlayerNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        nonPlayerNameTextField.attributedPlaceholder = NSAttributedString(string: "Non-Player Name", attributes: [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont(name: kStandardFontName, size: kStandardFontSize)!])
        nonPlayerNameTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        nonPlayerNameTextField.layer.cornerRadius = 5.0
        nonPlayerNameTextField.textColor = UIColor.darkGrayColor()
        nonPlayerNameTextField.keyboardType = UIKeyboardType.Default
        nonPlayerNameTextField.textAlignment = .Left
        nonPlayerNameTextField.sizeToFit()
        
        self.view.addSubview(nonPlayerNameTextField)
    }
    
    func configureCardIdTextField() {
        
        cardIdTextField.frame = CGRectZero
        cardIdTextField.layer.borderWidth = 1.0
        cardIdTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        cardIdTextField.attributedPlaceholder = NSAttributedString(string: "Card #", attributes: [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont(name: kStandardFontName, size: kStandardFontSize)!])
        cardIdTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        cardIdTextField.layer.cornerRadius = 5.0
        cardIdTextField.textColor = UIColor.darkGrayColor()
        cardIdTextField.keyboardType = UIKeyboardType.Default
        cardIdTextField.textAlignment = .Left
        cardIdTextField.sizeToFit()
        
        self.view.addSubview(cardIdTextField)
    }
    
    func configureSetTextField() {
        setTextField.frame = CGRectZero
        setTextField.layer.borderWidth = 1.0
        setTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        setTextField.attributedPlaceholder = NSAttributedString(string: "Set Name", attributes: [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont(name: kStandardFontName, size: kStandardFontSize)!])
        setTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        setTextField.layer.cornerRadius = 5.0
        setTextField.textColor = UIColor.darkGrayColor()
        setTextField.keyboardType = UIKeyboardType.Default
        setTextField.textAlignment = .Left
        setTextField.sizeToFit()
        
        self.view.addSubview(setTextField)
    }
    
    func configureSubSetTextField() {
        subSetTextField.frame = CGRectZero
        subSetTextField.layer.borderWidth = 1.0
        subSetTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        subSetTextField.attributedPlaceholder = NSAttributedString(string: "Subset Name", attributes: [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont(name: kStandardFontName, size: kStandardFontSize)!])
        subSetTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        subSetTextField.layer.cornerRadius = 5.0
        subSetTextField.textColor = UIColor.darkGrayColor()
        subSetTextField.keyboardType = UIKeyboardType.Default
        subSetTextField.textAlignment = .Left
        subSetTextField.sizeToFit()
        
        self.view.addSubview(subSetTextField)
    }
    
    func configureYearTextField() {
        yearTextField.frame = CGRectZero
        yearTextField.layer.borderWidth = 1.0
        yearTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        yearTextField.attributedPlaceholder = NSAttributedString(string: "Year", attributes: [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont(name: kStandardFontName, size: kStandardFontSize)!])
        yearTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        yearTextField.layer.cornerRadius = 5.0
        yearTextField.textColor = UIColor.darkGrayColor()
        yearTextField.keyboardType = UIKeyboardType.Default
        yearTextField.textAlignment = .Left
        yearTextField.sizeToFit()
        
        self.view.addSubview(yearTextField)
    }
    
    func configureSpSwitch() {
        spSwitch.frame = CGRectZero
        
        self.view.addSubview(spSwitch)
    }
    
    func configureRcSwitch() {
        rcSwitch.frame = CGRectZero
        
        self.view.addSubview(rcSwitch)
    }
    
    func configureNotesTextField() {
        notesTextField.frame = CGRectZero
        notesTextField.layer.borderWidth = 1.0
        notesTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        notesTextField.attributedPlaceholder = NSAttributedString(string: "Notes (ie - error, 45 of 100, game-used", attributes: [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont(name: kStandardFontName, size: kStandardFontSize)!])
        notesTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        notesTextField.layer.cornerRadius = 5.0
        notesTextField.textColor = UIColor.darkGrayColor()
        notesTextField.keyboardType = UIKeyboardType.Default
        notesTextField.textAlignment = .Left
        notesTextField.sizeToFit()
        
        self.view.addSubview(notesTextField)
    }
    
    func configureAutoPopulatedCardInfo() {
    if (baseballCard != nil) {
        playerFirstNameTextField.text = baseballCard["firstName"] as String
        playerLastNameTextField.text = baseballCard["lastName"] as String
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
            collectionBaseballCard["firstName"] = playerFirstNameTextField.text
            collectionBaseballCard["lastName"] = playerLastNameTextField.text
            collectionBaseballCard["cardId"] = cardIdTextField.text
            collectionBaseballCard["nonPlayerName"] = nonPlayerNameTextField.text
            collectionBaseballCard["notes"] = notesTextField.text
            collectionBaseballCard["rc"] = "notImplemented"
            collectionBaseballCard["set"] = setTextField.text
            collectionBaseballCard["sp"] = "notImplemented"
            collectionBaseballCard["subSet"] = subSetTextField.text
            collectionBaseballCard["year"] = yearTextField.text
            
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
