//
//  TweetNIbCell.swift
//  TwitterClient
//
//  Created by Sergelenbaatar Tsogtbaatar on 3/23/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit

class TweetNibCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            self.tweetLabel.text = tweet.text
            self.usernameLabel.text = tweet.user?.name ?? "Unknown User"
            
            if let user = tweet.user {
                UIImage.fetchImageWith(user.profileImageURL) { (image) in
                    self.userImageView.image = image
                }
            }
           
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
