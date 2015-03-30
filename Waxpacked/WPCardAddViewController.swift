//
//  WPCardAddViewController.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 3/23/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit

class WPCardAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {

    var scrollView: UIScrollView!
    var containerView = UIView()
    var baseballCard = PFObject(className:"BaseballCard")
    let cardSubjectTypeSegmentedControl = UISegmentedControl(items:["Player"," Non-Player"])
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
        navigationController?.toolbarHidden = true
        
        view.backgroundColor = kBackgroundColor
        cardSubjectTypeSegmentedControl.selectedSegmentIndex = 0
        
        self.scrollView = UIScrollView()
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(view.frame.width, view.frame.height * 1.5)
        
        containerView = UIView()
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
        
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
//        configureNonPlayerNameTextField()
        configureCardIdTextField()
        configureNotesTextField()
        configureRcSwitch()
        configureSetTextField()
        configureSpSwitch()
        configureSubSetTextField()
        configureYearTextField()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
        
        cardFrontImageView.center.x = view.center.x - (view.frame.width / 4)
        cardFrontImageView.center.y = view.frame.height/5
        
        cardBackImageView.center.x = view.center.x + (view.frame.width / 4)
        cardBackImageView.center.y = view.frame.height/5
        
        userCaptionTextField.center.x = view.center.x
        userCaptionTextField.center.y = view.frame.height / 2.5
        
        cardSubjectTypeSegmentedControl.center.x = view.center.x
        cardSubjectTypeSegmentedControl.center.y = view.frame.height/2.2
        
        playerFirstNameTextField.center.x = view.center.x - (view.frame.width / 5)
        playerFirstNameTextField.center.y = view.frame.height/1.8
        
        playerLastNameTextField.center.x = view.center.x + (view.frame.width / 5)
        playerLastNameTextField.center.y = view.frame.height/1.8
        
//        nonPlayerNameTextField.center.x = view.center.x
//        nonPlayerNameTextField.center.y = view.frame.height/1.8
        
        cardIdTextField.center.x = view.center.x
        cardIdTextField.center.y = view.frame.height/1.6
        
        setTextField.center.x = view.center.x
        setTextField.center.y = view.frame.height/1.5
        
        subSetTextField.center.x = view.center.x
        subSetTextField.center.y = view.frame.height/1.4
        
        yearTextField.center.x = view.center.x
        yearTextField.center.y = view.frame.height/1.3
        
        rcSwitch.center.x = view.center.x - (view.frame.width / 5)
        rcSwitch.center.y = view.frame.height/1.2
        
        spSwitch.center.x = view.center.x + (view.frame.width / 5)
        spSwitch.center.y = view.frame.height/1.2
        
        notesTextField.center.x = view.center.x
        notesTextField.center.y = view.frame.height/1.1
        
        addCardToCollectionButton.center.x = view.center.x
        addCardToCollectionButton.center.y = view.frame.height / 1.05
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
        let defaultCardImageView = UIImage(named: "AddCardFront")
        cardFrontImageView.frame = CGRectMake(0, 0, view.frame.width / 3, view.frame.height / 3)
        cardFrontImageView.center.x = view.center.x
        cardFrontImageView.image = defaultCardImageView
        cardFrontImageView.contentMode = .ScaleAspectFit
        
        containerView.addSubview(cardFrontImageView)
    }
    
    func configureCardBackImageView() {
        let defaultCardImageView = UIImage(named: "AddCardBack")
        cardBackImageView.frame = CGRectMake(0, 0, view.frame.width / 3, view.frame.height / 3)
        cardBackImageView.center.x = view.center.x
        cardBackImageView.image = defaultCardImageView
        cardBackImageView.contentMode = .ScaleAspectFit
        
        containerView.addSubview(cardBackImageView)
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
        
        containerView.addSubview(userCaptionTextField)
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
        
        containerView.addSubview(playerFirstNameTextField)
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
        
        containerView.addSubview(playerLastNameTextField)
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
        
        containerView.addSubview(nonPlayerNameTextField)
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
        
        containerView.addSubview(cardIdTextField)
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
        
        containerView.addSubview(setTextField)
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
        
        containerView.addSubview(subSetTextField)
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
        
        containerView.addSubview(yearTextField)
    }
    
    func configureSpSwitch() {
        spSwitch.frame = CGRectZero
        
        containerView.addSubview(spSwitch)
    }
    
    func configureRcSwitch() {
        rcSwitch.frame = CGRectZero
        
        containerView.addSubview(rcSwitch)
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
        
        containerView.addSubview(notesTextField)
    }
    
    func configureAutoPopulatedCardInfo() {
    if (baseballCard != nil) {
        playerFirstNameTextField.text = baseballCard["firstName"] as String
        playerLastNameTextField.text = baseballCard["lastName"] as String
        cardIdTextField.text = baseballCard["cardId"] as String
        setTextField.text = baseballCard["set"] as String
        subSetTextField.text = baseballCard["subSet"] as String
//        yearTextField.text = baseballCard["year"] as String
//        if (baseballCard["notes"] as NSString != "N/A") {
//            notesTextField.text = baseballCard["notes"] as String
//        } else {
//            notesTextField.text = nil
//        }
//        if (baseballCard["rc"] as NSString != "N/A") {
//            rcSwitch.setOn(false, animated: false)
//        } else {
//            rcSwitch.setOn(true, animated: false)
//        }
//        if (baseballCard["sp"] as NSString != "N/A") {
//            spSwitch.setOn(false, animated: false)
//        } else {
//            spSwitch.setOn(true, animated: false)
//        }
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
        
        containerView.addSubview(addCardToCollectionButton)
        
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
