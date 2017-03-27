//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Sergelenbaatar Tsogtbaatar on 3/22/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    var tweet: Tweet!
    
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var retweetedStatus: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    func setUp() {
        self.text.text = tweet.text
        self.id.text = tweet.id
        self.retweetedStatus.text = tweet.retweeted.description
        self.userName.text = tweet.user?.screenName
        UIImage.fetchImageWith((tweet.user?.profileImageURL)!) { (image) in
            if let image = image {
                self.userImageView.image = image
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "feedSegue" {
            let tweetUser = tweet.user
            
            if let destinationViewController = segue.destination as? FeedViewController {
                destinationViewController.newUser = tweetUser
                
                
            }
        }
    }
}
