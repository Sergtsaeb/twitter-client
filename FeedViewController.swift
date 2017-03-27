//
//  FeedViewController.swift
//  TwitterClient
//
//  Created by Sergelenbaatar Tsogtbaatar on 3/23/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var newUser: User!
    
    var tweets = [Tweet]() {
        didSet {
//            print(tweets.first?.user)
             tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil)
        self.tableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        update()
    }
    
    func update() {
        API.shared.getTweetsFor(newUser.screenName) { (tweets) in
            if tweets != nil {
                OperationQueue.main.addOperation {
                    self.tweets = tweets!
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetNibCell.identifier, for: indexPath) as! TweetNibCell
        
        let tweet = self.tweets[indexPath.row]
        cell.tweet = tweet
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
   
}

