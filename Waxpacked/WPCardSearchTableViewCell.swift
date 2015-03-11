//
//  WPCardSearchTableViewCell.swift
//  Waxpacked
//
//  Created by Jeremy Peronto on 3/9/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit

class WPCardSearchTableViewCell: PFTableViewCell {
    
    var cardImageView = PFImageView()
    var cardSubjectNameLabel = UILabel()
    var setNameLabel = UILabel()
    var subSetNameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cardImageView.frame = CGRectMake(10, 10, 60, 60)
        
        cardImageView.layer.cornerRadius = cardImageView.frame.size.width / 2;
        cardImageView.clipsToBounds = true
        cardImageView.layer.borderWidth = 1.0
        cardImageView.layer.borderColor = UIColor.darkGrayColor().CGColor
        cardImageView.tag = 1
        
        addSubview(cardImageView)
        
        cardSubjectNameLabel.frame = CGRectMake((contentView.frame.width - cardImageView.frame.maxX)/3, contentView.frame.height/7, 0, 0)
        cardSubjectNameLabel.tag = 2
        cardSubjectNameLabel.textColor = UIColor.darkGrayColor()
        cardSubjectNameLabel.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        addSubview(cardSubjectNameLabel)
        
        setNameLabel.frame = CGRectMake((contentView.frame.width - cardImageView.frame.maxX)/3, contentView.frame.height/2, 0, 0)
        setNameLabel.tag = 3
        setNameLabel.textColor = UIColor.darkGrayColor()
        setNameLabel.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        addSubview(setNameLabel)
        
        subSetNameLabel.frame = CGRectMake((contentView.frame.width - cardImageView.frame.maxX)/3, contentView.frame.height/(1/7), 0, 0)
        subSetNameLabel.tag = 4
        subSetNameLabel.textColor = UIColor.darkGrayColor()
        subSetNameLabel.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        addSubview(subSetNameLabel)
        
        backgroundColor = kBackgroundColor
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
