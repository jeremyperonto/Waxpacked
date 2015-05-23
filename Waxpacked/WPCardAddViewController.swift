//
//  WPCardAddViewController.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 3/23/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit

class WPCardAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, UITextFieldDelegate {

    var scrollView: UIScrollView!
    var containerView = UIView()
    var baseballCard = PFObject(className:"BaseballCard")
    var cardSubjectSegmentedControl = UISegmentedControl()
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
    var clearFieldsLabel = UILabel()
    
    var addCardToCollectionButton = UIButton()
    
    var isPlayerCard = Bool()
    var areAllFieldsClear = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add Card"
        navigationController?.toolbarHidden = true
        
        view.backgroundColor = kBackgroundColor
        
        self.scrollView = UIScrollView()
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(view.frame.width, view.frame.height * 1.15)
        
        containerView = UIView()
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
        
        viewDidLayoutSubviews()
        playerOrNonPlayerBool()
        configureCardFrontImageView()
        configureCardBackImageView()
        configureUserCaptionTextField()
        configureCardSubjectSegmentedControl()
        configurePlayerFirstAndLastNameTextField()
//        configureNonPlayerNameTextField()
        configureAddCardToCollectionButton()
        configureAutoPopulatedCardInfo()

        configureUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.toolbarHidden = true
        playerOrNonPlayerBool()
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
        
        cardSubjectSegmentedControl.frame = CGRectMake(0, 0, view.frame.width * 0.8, view.frame.height / 15)
        cardSubjectSegmentedControl.center.x = view.center.x
        cardSubjectSegmentedControl.center.y =  view.frame.height/2.2
        
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
        
        clearFieldsLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width/1.5, height: view.frame.width/2)
        clearFieldsLabel.center.x = containerView.center.x
        clearFieldsLabel.center.y = containerView.frame.height * 0.9
        
        addCardToCollectionButton.center.x = view.center.x
        addCardToCollectionButton.center.y = view.frame.height / 1.05
    }
    
    func playerOrNonPlayerBool(){
        if (baseballCard["nonPlayerName"] as! String != "N/A"){
            isPlayerCard = false
            cardSubjectSegmentedControl.selectedSegmentIndex = 1
        }
        else {
            isPlayerCard = true
            cardSubjectSegmentedControl.selectedSegmentIndex = 0
        }
    }
    
    func changeCardSubjectSegmentedControl(sender: UISegmentedControl){
        
        areFieldsClearCheck()
        
        switch sender.selectedSegmentIndex
        {
        case 0: //If text fields filled
            if (areAllFieldsClear != true){
                let alertController = UIAlertController(title: "Clear All Fields", message: "Changing the subject of your card will delete entered data and remove connection to card data.", preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                    self.cardSubjectSegmentedControl.selectedSegmentIndex = 1
                    self.isPlayerCard = false
                    println("Non-Player Card")
                }
                alertController.addAction(cancelAction)
                
                let destroyAction = UIAlertAction(title: "Change Subject", style: .Destructive) { (action) in
                    self.cardSubjectSegmentedControl.selectedSegmentIndex = 0
                    self.isPlayerCard = true
                    println("Player Card")
                    self.clearAllFields()
                    self.areAllFieldsClear = true
                }
                alertController.addAction(destroyAction)
                
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
            }
            else {
                self.cardSubjectSegmentedControl.selectedSegmentIndex = 0
                self.isPlayerCard = true
                println("Player Card")
                self.clearAllFields()
                self.areAllFieldsClear = true
            }
            
        default:
            if (areAllFieldsClear != true){
                let alertController = UIAlertController(title: "Clear All Fields", message: "Changing the subject of your card will delete entered data and remove connection to card data.", preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                    self.cardSubjectSegmentedControl.selectedSegmentIndex = 0
                    self.isPlayerCard = true
                    println("Player Card")
                }
                alertController.addAction(cancelAction)
                
                let destroyAction = UIAlertAction(title: "Change Subject", style: .Destructive) { (action) in
                    self.cardSubjectSegmentedControl.selectedSegmentIndex = 1
                    self.isPlayerCard = false
                    println("Non-Player Card")
                    self.clearAllFields()
                    self.areAllFieldsClear = true
                }
                alertController.addAction(destroyAction)
                
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
            }
            else {
                self.cardSubjectSegmentedControl.selectedSegmentIndex = 1
                self.isPlayerCard = false
                println("Non-Player Card")
                self.clearAllFields()
                self.areAllFieldsClear = true
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField === userCaptionTextField) {
            playerFirstNameTextField.becomeFirstResponder()
        } else if (textField === playerFirstNameTextField) {
            playerLastNameTextField.resignFirstResponder()
        }
        return true
    }
    
   //MARK -- Setup UI Elements
    
    func configureCardFrontImageView() {
        let defaultCardImageView = UIImage(named: "AddCardFront")
        cardFrontImageView.frame = CGRectMake(0, 0, view.frame.width / 3, view.frame.height / 3)
        cardFrontImageView.center.x = view.center.x
        cardFrontImageView.image = defaultCardImageView
        cardFrontImageView.contentMode = .ScaleAspectFit
        cardFrontImageView.userInteractionEnabled = true
        
        let imageTouch = UITapGestureRecognizer(target: self, action: "cardFrontImagePicker")
        imageTouch.numberOfTapsRequired = 1
        cardFrontImageView.addGestureRecognizer(imageTouch)
        
        containerView.addSubview(cardFrontImageView)
    }
    
    func configureCardBackImageView() {
        let defaultCardImageView = UIImage(named: "AddCardBack")
        cardBackImageView.frame = CGRectMake(0, 0, view.frame.width / 3, view.frame.height / 3)
        cardBackImageView.center.x = view.center.x
        cardBackImageView.image = defaultCardImageView
        cardBackImageView.contentMode = .ScaleAspectFit
        cardBackImageView.userInteractionEnabled = true
        
        let imageTouch = UITapGestureRecognizer(target: self, action: "cardBackImagePicker")
        imageTouch.numberOfTapsRequired = 1
        cardBackImageView.addGestureRecognizer(imageTouch)
        
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
    
    func configureCardSubjectSegmentedControl() {
        cardSubjectSegmentedControl = UISegmentedControl(items:["Single Player Subject","Alternate Subject"])
        cardSubjectSegmentedControl.frame = CGRectMake(60, 250,200, 30)
        cardSubjectSegmentedControl.tintColor = UIColor.darkGrayColor()
        cardSubjectSegmentedControl.addTarget(self, action: "changeCardSubjectSegmentedControl:", forControlEvents: .ValueChanged)
        
        containerView.addSubview(cardSubjectSegmentedControl)
    }
    
    func configurePlayerFirstAndLastNameTextField() {
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
        
        containerView.addSubview(playerFirstNameTextField)
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
    
    func configureUI() {
        
        cardIdTextField.frame = CGRectZero
        cardIdTextField.layer.borderWidth = 1.0
        cardIdTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        cardIdTextField.attributedPlaceholder = NSAttributedString(string: "Card #", attributes: [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont(name: kStandardFontName, size: kStandardFontSize)!])
        cardIdTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        cardIdTextField.layer.cornerRadius = 5.0
        cardIdTextField.textColor = UIColor.darkGrayColor()
        cardIdTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        cardIdTextField.textAlignment = .Left
        cardIdTextField.sizeToFit()
        
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
        
        yearTextField.frame = CGRectZero
        yearTextField.layer.borderWidth = 1.0
        yearTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        yearTextField.attributedPlaceholder = NSAttributedString(string: "Year", attributes: [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont(name: kStandardFontName, size: kStandardFontSize)!])
        yearTextField.layer.borderColor = UIColor.darkGrayColor().CGColor
        yearTextField.layer.cornerRadius = 5.0
        yearTextField.textColor = UIColor.darkGrayColor()
        yearTextField.keyboardType = UIKeyboardType.NumberPad
        yearTextField.textAlignment = .Left
        yearTextField.sizeToFit()
        
        spSwitch.frame = CGRectZero
        
        rcSwitch.frame = CGRectZero
        
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
        
        clearFieldsLabel.text = "Clear All Fields"
        clearFieldsLabel.textAlignment = .Center
        clearFieldsLabel.font = UIFont(name: kTitleFontName, size: kTitleFontSize)
        clearFieldsLabel.textColor = UIColor.redColor()
        clearFieldsLabel.userInteractionEnabled = true
        
        let labelTouch = UITapGestureRecognizer(target: self, action: "clearAllFieldsButtonPressed")
        labelTouch.numberOfTapsRequired = 1
        clearFieldsLabel.addGestureRecognizer(labelTouch)
        
        
        containerView.addSubview(cardIdTextField)
        containerView.addSubview(setTextField)
        containerView.addSubview(subSetTextField)
        containerView.addSubview(yearTextField)
        containerView.addSubview(spSwitch)
        containerView.addSubview(rcSwitch)
        containerView.addSubview(notesTextField)
        containerView.addSubview(clearFieldsLabel)
    }
    
    //MARK -- Image Picker
    
    func cardFrontImagePicker() {
        var frontImagePicker: UIImagePickerController = UIImagePickerController()
        frontImagePicker.sourceType = .Camera
        frontImagePicker.delegate = self
        frontImagePicker.navigationBar.tintColor = UIColor.darkGrayColor()
        
        let returnIcon = UIBarButtonItem(image: kNavBarReturnIcon, style: .Plain, target: navigationController, action: "popViewControllerAnimated:")
        returnIcon.tintColor = kToolbarIconColor
        
        presentViewController(frontImagePicker, animated: true, completion: nil)
    }
    
    func cardBackImagePicker() {
        var backImagePicker: UIImagePickerController = UIImagePickerController()
        backImagePicker.sourceType = .Camera
        backImagePicker.delegate = self
        backImagePicker.navigationBar.tintColor = UIColor.darkGrayColor()
        
        let returnIcon = UIBarButtonItem(image: kNavBarReturnIcon, style: .Plain, target: navigationController, action: "popViewControllerAnimated:")
        returnIcon.tintColor = kToolbarIconColor
        
        presentViewController(backImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cardFrontImagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let pickedImage:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let scaledImage = scaleImageWith(pickedImage)
        cardFrontImageView.image = scaledImage

//        let imageData = UIImagePNGRepresentation(scaledImage)
//        let imageFile:PFFile = PFFile(data: imageData)
//        
//        PFObject(className:"CollectionBaseballCard").setObject(imageFile, forKey: kBaseballCardFrontImage)
//        PFObject(className:"CollectionBaseballCard").saveInBackgroundWithBlock {
//            (success: Bool, error: NSError!) -> Void in
//            if (success) {
//                self.cardFrontImageView.image = scaledImage
//            } else {
//                var errorAlert = UIAlertController(title: "Oops. Something went wrong.", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert)
//                errorAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
//                    
//                }))
//                self.presentViewController(errorAlert, animated: true, completion: nil)
//            }
//        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func cardBackImagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let pickedImage:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage

//        let scaledImage = scaleImageWith(pickedImage)
//        let imageData = UIImagePNGRepresentation(scaledImage)
//        let imageFile:PFFile = PFFile(data: imageData)
//        
//        PFObject(className:"CollectionBaseballCard").setObject(imageFile, forKey: kBaseballCardBackImage)
//        PFObject(className:"CollectionBaseballCard").saveInBackgroundWithBlock {
//            (success: Bool, error: NSError!) -> Void in
//            if (success) {
//                self.cardBackImageView.image = scaledImage
//            } else {
//                var errorAlert = UIAlertController(title: "Oops. Something went wrong.", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert)
//                errorAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
//                    
//                }))
//                self.presentViewController(errorAlert, animated: true, completion: nil)
//            }
//        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scaleImageWith(image:UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(kBaseballCardPhotoDimensions, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, kBaseballCardPhotoDimensions.width, kBaseballCardPhotoDimensions.height))
        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return newImage
    }
    
    //MARK -- Populate Card Data
    
    func configureAutoPopulatedCardInfo() {
    if (baseballCard != nil) {
        playerFirstNameTextField.text = baseballCard["firstName"] as! String
        playerLastNameTextField.text = baseballCard["lastName"] as! String
        cardIdTextField.text = baseballCard["cardId"] as! String
        setTextField.text = baseballCard["set"] as! String
        subSetTextField.text = baseballCard["subSet"] as! String
        var yearInt = baseballCard["year"] as! Int
        var yearString = "\(yearInt)" as String
        yearTextField.text = yearString
        if (baseballCard["notes"] as! NSString != "N/A") {
            notesTextField.text = baseballCard["notes"] as! String
        } else {
            notesTextField.text = nil
        }
        if (baseballCard["rc"] as! NSString != "N/A") {
            rcSwitch.setOn(false, animated: false)
        } else {
            rcSwitch.setOn(true, animated: false)
        }
        if (baseballCard["sp"] as! NSString != "N/A") {
            spSwitch.setOn(false, animated: false)
        } else {
            spSwitch.setOn(true, animated: false)
        }
    } else {
        println("No card associated")
    }
    }
    
    func configureAddCardToCollectionButton() {
        addCardToCollectionButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        addCardToCollectionButton.frame = CGRectMake(0, 0, 100, 50)
        addCardToCollectionButton.backgroundColor = UIColor.redColor()
        //addCardToCollectionButton.imageForState(<#state: UIControlState#>)
        addCardToCollectionButton.setTitle("Share →", forState: UIControlState.Normal)
        addCardToCollectionButton.addTarget(self, action: "didPushAddCardToCollectionButton", forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(addCardToCollectionButton)
        
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
            collectionBaseballCard["year"] = yearTextField.text.toInt()
            
            // Add a relation between the Collection Card and Read-only Card
            collectionBaseballCard["parent"] = PFObject(withoutDataWithClassName:"BaseballCard", objectId:"\(baseballCard.objectId)")
            
            // Save both card post, data, and comments
            collectionBaseballCard.saveInBackgroundWithBlock {
                (success: Bool, error: NSError!) -> Void in
                if (success) {
                    // The object has been saved.
                    println("success")
                    self.clearAllFields()
                    self.pushToHomeViewController()
                } else {
                    // There was a problem, check error.description
                    println("failed to save -- add error warning")
                }
            }
        } else {
            println("Cancelled")
        }
    
    }
    
    func clearAllFieldsButtonPressed() {
        let alertController = UIAlertController(title: "Clear All Fields", message: "Clearing fields will delete entered data and eliminate connection to card data.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "Clear Fields", style: .Destructive) { (action) in
            self.clearAllFields()
        }
        alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }
    
    func clearAllFields() {
        //Implement on exit from VC and when user presses the clear button -- give warning on the clear button
        playerFirstNameTextField.text = nil
        playerLastNameTextField.text = nil
        nonPlayerNameTextField.text = nil
        cardIdTextField.text = nil
        setTextField.text = nil
        subSetTextField.text = nil
        yearTextField.text = nil
        notesTextField.text = nil
        rcSwitch.setOn(false, animated: false)
        spSwitch.setOn(false, animated: false)
    }
    
    func areFieldsClearCheck() {
        if (playerFirstNameTextField.text != "" && playerLastNameTextField.text != "" && nonPlayerNameTextField.text != "" && cardIdTextField.text != "" && setTextField.text != "" && subSetTextField.text != "" && yearTextField.text != "" && notesTextField.text != "") {
            areAllFieldsClear = false
            println("\(areAllFieldsClear)")
        }
        else {
            areAllFieldsClear = true
            println("\(areAllFieldsClear)")
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
