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
                            self.profileImageView.image = image
                        }
                        else {
                            println(error)
                            self.presentErrorMessage(error)
                        }
                    })
                }
            }
            else {
                // Log details of failure
                println(error)
                self.presentErrorMessage(error)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
        configureImageView()
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
        profileImageView.center.x = view.center.x
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
        profileImageView.center.x = view.center.x
    }
    
    func imagePicker() {
        var imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.delegate = self
        imagePicker.navigationBar.tintColor = UIColor.whiteColor()
        
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
            }
            else {
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
}
