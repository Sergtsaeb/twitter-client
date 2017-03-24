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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    func setUp() {
        self.text.text = tweet.text
        self.id.text = tweet.id
        self.retweetedStatus.text = tweet.retweeted.description
        self.userName.text = tweet.user?.screenName
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "feedSegue" {
            guard let destinationViewController = segue.destination as? FeedViewController else {return}
        }
    }

}
