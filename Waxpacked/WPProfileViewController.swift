//
//  WPProfileViewController.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 2/20/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit

class WPProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var profileUser = PFUser()
    var profileImageView = UIImageView()
    var profileUsernameLabel = UILabel()
    var profileUserBioLabel = UILabel()
    var numberOfFollowersLabel = UILabel()
    var numberOfFollowers:Int32 = 0 {
        didSet {
            numberOfFollowersLabel.text = "Followers: \(numberOfFollowers)"
        }
    }
    
    var numberFollowingLabel = UILabel()
    var numberFollowing:Int32 = 0 {
        didSet {
            numberFollowingLabel.text = "Following: \(numberFollowing)"
        }
    }
    
    var friendStatus = 1
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    func loadData() {
        var findUser = PFUser.query()
        findUser.whereKey("username", equalTo: profileUser.username)
        findUser.getFirstObjectInBackgroundWithBlock { (object:PFObject!, error:NSError!) -> Void in
            if (error == nil) {
                if let profileImage:PFFile = object["profileImage"] as? PFFile {
                    profileImage.getDataInBackgroundWithBlock({ (imageData: NSData!, error:NSError!) -> Void in
                        if (error == nil) {
                            let image:UIImage = UIImage(data: imageData)!
                            dispatch_async(dispatch_get_main_queue(), {
                                self.profileImageView.image = image
                            });
                        }
                        else {
                            self.presentErrorMessage(error)
                        }
                    })
                }
            }
            else {
                self.presentErrorMessage(error)
            }
        }
        
        //Get followers number
        var followers = PFQuery(className: "Followers")
        followers.whereKey("user", equalTo: self.profileUser.username)
        followers.countObjectsInBackgroundWithBlock { (numOfFollowers:Int32, error:NSError!) -> Void in
            if (error == nil) {
                dispatch_async(dispatch_get_main_queue(),{
                    self.numberOfFollowers = numOfFollowers
                });
            }
            else{
                self.presentErrorMessage(error)
            }
        }
        
        //Get following number
        var following = PFQuery(className: "Followers")
        following.whereKey("follower", equalTo: self.profileUser.username)
        following.countObjectsInBackgroundWithBlock { (numFollowing:Int32, error:NSError!) -> Void in
            if (error == nil) {
                dispatch_async(dispatch_get_main_queue(),{
                    self.numberFollowing = numFollowing
                });
            }
            else{
                self.presentErrorMessage(error)
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationToolBar()

        if PFUser.currentUser() == profileUser {
            title = "My Profile"
        }
        else {
            title = "\(profileUser.username)"
        }
        
        view.backgroundColor = kBackgroundColor
        
        let returnIcon = UIBarButtonItem(image: kNavBarReturnIcon, style: .Plain, target: navigationController, action: "popViewControllerAnimated:")
        returnIcon.tintColor = kToolbarIconColor
        navigationItem.leftBarButtonItem = returnIcon
        
        let followButton = UIBarButtonItem(title: "Follow", style: .Plain, target: self, action: "followUser")
        followButton.tintColor = kToolbarIconColor
        navigationItem.rightBarButtonItem = followButton
        
        switch friendStatus {
        case 1 : navigationItem.rightBarButtonItem?.title = "Follow"
        case 2 : navigationItem.rightBarButtonItem?.title = "Unfollow"
        default : navigationItem.rightBarButtonItem = nil
        }
        
        configureImageView()
        configureUsernameLabel()
        configureUserBioLabel()
        configureNumberFollowersLabel()
        configureNumberFollowingLabel()
        loadData()
    }
    
    func presentErrorMessage(error: NSError) {
        //Log details of failure
        println(error)
        var errorAlert = UIAlertController(title: "Oops. Something went wrong.", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        self.presentViewController(errorAlert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func configureImageView() {
        let defaultProfileImage = kProfileDefaultProfileImage
        profileImageView.frame = CGRect(x: 0, y: 20, width: view.frame.width/4, height: view.frame.width/4)
        profileImageView.center.x = view.center.x - 100
        profileImageView.image = kProfileDefaultProfileImage
        profileImageView.contentMode = .ScaleAspectFit
        
        if PFUser.currentUser() == profileUser {
            profileImageView.userInteractionEnabled = true
        }
        else {
            profileImageView.userInteractionEnabled = false
        }
        
        let imageTouch = UITapGestureRecognizer(target: self, action: "imagePicker")
        imageTouch.numberOfTapsRequired = 1
        profileImageView.addGestureRecognizer(imageTouch)
        
        self.view.addSubview(profileImageView)
    
    }
    
    override func viewWillLayoutSubviews() {
        profileImageView.frame = CGRect(x: view.center.x, y: 20, width: view.frame.width/4, height: view.frame.width/4)
        profileImageView.center.x = view.center.x
        
        profileUsernameLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width/1.5, height: view.frame.width/2)
        profileUsernameLabel.center.x = view.center.x
        profileUsernameLabel.center.y = view.frame.width/2.8

        profileUserBioLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width/1.25, height: view.frame.width/1.5)
        profileUserBioLabel.center.x = view.center.x
        profileUserBioLabel.center.y = view.frame.width/2.2

        numberOfFollowersLabel.frame = CGRect(x: 0, y: 70, width: view.frame.width/1.25, height: view.frame.width/1.5)
        numberOfFollowersLabel.center.x = view.center.x - 100
        numberOfFollowersLabel.center.y = view.frame.width/1.8
        
        numberFollowingLabel.frame = CGRect(x: 0, y: 70, width: view.frame.width/1.25, height: view.frame.width/1.5)
        numberFollowingLabel.center.x = view.center.x + 100
        numberFollowingLabel.center.y = view.frame.width/1.8
    }
    
    override func viewDidLayoutSubviews() {
        profileImageView.frame = CGRect(x: view.center.x, y: 20, width: view.frame.width/4, height: view.frame.width/4)
        profileImageView.center.x = view.center.x
        
        numberOfFollowersLabel.center.x = view.center.x - 100
        
        numberFollowingLabel.center.x = view.center.x + 100
        
        //profileUserBioLabel.center.y = view.center.y + 40
        
        profileUsernameLabel.center.x = view.center.x
    }
    
    func imagePicker() {
        var imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.delegate = self
        imagePicker.navigationBar.tintColor = UIColor.darkGrayColor()
        
        let returnIcon = UIBarButtonItem(image: kNavBarReturnIcon, style: .Plain, target: navigationController, action: "popViewControllerAnimated:")
        returnIcon.tintColor = kToolbarIconColor
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let pickedImage:UIImage = info[UIImagePickerControllerOriginalImage] as UIImage
        let scaledImage = scaleImageWith(pickedImage)
        let imageData = UIImagePNGRepresentation(scaledImage)
        let imageFile:PFFile = PFFile(data: imageData)
        PFUser.currentUser().setObject(imageFile, forKey: kParseClassNameProfileImage)
        PFUser.currentUser().saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                self.profileImageView.image = scaledImage
            } else {
                var errorAlert = UIAlertController(title: "Oops. Something went wrong.", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                    
                }))
                self.presentViewController(errorAlert, animated: true, completion: nil)
            }
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scaleImageWith(image:UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(kProfilePhotoDimensions, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, kProfilePhotoDimensions.width, kProfilePhotoDimensions.height))
        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return newImage
    }
    
    func configureUsernameLabel() {
        profileUsernameLabel.text = profileUser.username
        profileUsernameLabel.textAlignment = .Center
        profileUsernameLabel.font = UIFont(name: kTitleFontName, size: kTitleFontSize)
        profileUsernameLabel.textColor = UIColor.darkGrayColor()
        
        self.view.addSubview(profileUsernameLabel)
    }
    
    func configureUserBioLabel() {
        profileUserBioLabel.text = "Bio not yet implemented"
        profileUserBioLabel.textAlignment = .Center
        profileUserBioLabel.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        profileUserBioLabel.textColor = UIColor.darkGrayColor()
        
        self.view.addSubview(profileUserBioLabel)
    }
    
    func configureNumberFollowersLabel() {
        numberOfFollowersLabel.text = "Followers: 0"
        numberOfFollowersLabel.textAlignment = .Center
        numberOfFollowersLabel.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        numberOfFollowersLabel.textColor = UIColor.darkGrayColor()
        numberOfFollowersLabel.userInteractionEnabled = true
        
        let followersLabelTouch = UITapGestureRecognizer(target: self, action: "pushToFollowersTable")
        followersLabelTouch.numberOfTapsRequired = 1
        numberOfFollowersLabel.addGestureRecognizer(followersLabelTouch)
        
        self.view.addSubview(numberOfFollowersLabel)
    }
    
    func configureNumberFollowingLabel() {
        numberFollowingLabel.text = "Following: 0"
        numberFollowingLabel.textAlignment = .Center
        numberFollowingLabel.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        numberFollowingLabel.textColor = UIColor.darkGrayColor()
        numberFollowingLabel.userInteractionEnabled = true
        
        let followingLabelTouch = UITapGestureRecognizer(target: self, action: "pushToFollowingTable")
        followingLabelTouch.numberOfTapsRequired = 1
        numberFollowingLabel.addGestureRecognizer(followingLabelTouch)
        
        self.view.addSubview(numberFollowingLabel)
    }
    
    func followUser() {
        var friendsRelation:PFRelation = PFUser.currentUser().relationForKey("friendsRelation")
        
        if friendStatus == 1 {
            friendsRelation.addObject(profileUser)
            PFUser.currentUser().saveInBackgroundWithBlock { (success:Bool, error: NSError!) -> Void in
                if (success) {
                    var followers = PFObject(className: "Followers")
                    followers.setObject(self.profileUser.username, forKey: "user")
                    followers.setObject(PFUser.currentUser().username, forKey: "follower")
                    followers.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
                        if (success) {
                            self.friendStatus = 2
                            self.navigationItem.rightBarButtonItem?.title = "Unfollow"
                            self.loadData()
                        } else {
                            self.presentErrorMessage(error)
                        }
                    }
                } else {
                    self.presentErrorMessage(error)
                }
            }
        }
        else {
            friendsRelation.removeObject(profileUser)
            PFUser.currentUser().saveInBackgroundWithBlock({ (success: Bool, error: NSError!) -> Void in
                if (success) {
                    var followers = PFQuery(className: "Followers")
                    followers.whereKey("user", equalTo: self.profileUser.username)
                    followers.whereKey("follower", equalTo: PFUser.currentUser().username)
                    followers.getFirstObjectInBackgroundWithBlock({ (object: PFObject!, error:NSError!) -> Void in
                        if (error == nil) {
                            object.deleteInBackgroundWithBlock({ (success: Bool, error: NSError!) -> Void in
                                if success {
                                    self.friendStatus = 1
                                    self.navigationItem.rightBarButtonItem?.title = "Follow"
                                    self.loadData()
                                }
                                else {
                                    self.presentErrorMessage(error)
                                }
                            })
                        }
                    })
                }
                else {
                    self.presentErrorMessage(error)
                }
            })
        }
    }
    
}
