//
//  WPLoginSignupViewController.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 2/18/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit

class WPLoginSignupViewController: PFLogInViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    //Required for custom programmatical instantiation

    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad( )
    {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
        delegate = self
        signUpController.delegate = self
        logInView.logo = UIImageView(image: UIImage(named: kLoginLogo))
        logInView.logo.contentMode = .Center
        signUpController.signUpView.logo = UIImageView(image: UIImage(named: kSignUpLogo))
        signUpController.signUpView.logo.contentMode = .Center
        
        if ( (PFUser.currentUser() ) != nil) {
            pushToMainViewController()
        }
    }
    
    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
        self.pushToMainViewController()
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!) {
        signUpController.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.pushToMainViewController()
        })
    }
    
    func pushToMainViewController() {
        logInView.passwordField.text = ""
        signUpController.signUpView.passwordField.text = ""
        let mainViewController = WPHomeTableViewController(style: .Plain)
        mainViewController.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.pushViewController(mainViewController, animated: false)
        navigationController?.navigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
