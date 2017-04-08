//
//  MyFoldingCell.swift
//  TwitterClient
//
//  Created by Cathy Oun on 4/7/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit
import FoldingCell

protocol MyFoldingCellDelegate {
    func didTapMoreDetail(_ sender: Any?)
}

class MyFoldingCell: FoldingCell {
    
    // foreground view
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetTitleLabel: UILabel!
    @IBOutlet weak var tweetSubtitleLabel: UILabel!
    
    // container view
    @IBOutlet weak var containerViewProfileImageView: UIImageView!
    @IBOutlet weak var containerViewUsernameLabel: UILabel!
    @IBOutlet weak var containerViewTweetLabel: UILabel!
    @IBOutlet weak var containerViewRetweetLabel: UILabel!
    
    var delegate: MyFoldingCellDelegate?
    
    var tweet: Tweet? {
        
        didSet {
            guard let tweet = tweet else { return }
            UIImage.fetchImageWith((tweet.user?.profileImageURL)!) { (image) in
                self.profileImageView.image = image
                self.containerViewProfileImageView.image = image
            }
            self.tweetTitleLabel.text = tweet.text
            self.tweetSubtitleLabel.text = tweet.user?.name
            self.containerViewTweetLabel.text = tweet.text
            self.containerViewRetweetLabel.text = tweet.retweeted ? "Retweeted" : "Not retweeted"
            self.containerViewUsernameLabel.text = tweet.user?.screenName
            
        }
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        // durations count equal it itemCount
        let durations = [0.2, 0.26, 0.2] // timing animation for each view
        return durations[itemIndex]
    }

    @IBAction func moreDetailButtonPressed(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.didTapMoreDetail(sender)
        }
    }
}
