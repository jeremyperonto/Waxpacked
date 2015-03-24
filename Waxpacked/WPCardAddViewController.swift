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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add Card"
        
        view.backgroundColor = kBackgroundColor
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
