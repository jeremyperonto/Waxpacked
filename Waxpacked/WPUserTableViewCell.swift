//
//  WPUserTableViewCell.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 2/23/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit

class WPUserTableViewCell: PFTableViewCell {
    
    var profileImageView = PFImageView()
    var label = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        profileImageView.setTranslatesAutoresizingMaskIntoConstraints(true)
        profileImageView.frame = CGRectMake(contentView.frame.width * 0.05, contentView.frame.height * 0.05, contentView.frame.height * 0.85, contentView.frame.height * 0.85)
        profileImageView.autoresizesSubviews = true
        profileImageView.contentMode = .ScaleAspectFill
        profileImageView.autoresizingMask = .FlexibleWidth | .FlexibleHeight

        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2;
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.tag = 1
        
        addSubview(profileImageView)
        
        label.frame = CGRectMake((contentView.frame.width - profileImageView.frame.maxX)/3, contentView.frame.height/2+5, 50, 50)
        label.tag = 2
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        addSubview(label)
        
        backgroundColor = kBackgroundColor
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
