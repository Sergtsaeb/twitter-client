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
    
//    @IBOutlet weak var user: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        update()
    }
    
    func update() {
        text.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    
    func setUp() {
        self.text.text = tweet.text
        self.id.text = tweet.id
        self.retweetedStatus.text = tweet.retweeted.description
//        self.user.text = tweet.user?.name
        
    }
    
    

}
