//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Sergelenbaatar Tsogtbaatar on 3/20/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit
import Foundation

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var allTweets = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var userProfile: User?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationController?.delegate = self
        
        let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil)
        
        self.tableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
        
        self.navigationItem.title = "My Timeline"
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        updateTimeline()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == TweetDetailViewController.identifier {
            
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                let selectedTweet = self.allTweets[selectedIndex]
                guard let destinationController = segue.destination as? TweetDetailViewController else { return }
                
                destinationController.tweet = selectedTweet
            }
        }
        
        if segue.identifier == ProfileViewController.identifier {
            guard let destinationController = segue.destination as? ProfileViewController else { return }
            
            API.shared.getUserInfo(callback: { (user) in
                destinationController.user = user
            })
            
            
        }
        
        
    }
    
    func updateTimeline() {
        
        self.activityIndicator.startAnimating()
        
        API.shared.getTweets { (tweets) in
            OperationQueue.main.addOperation {
                self.allTweets = tweets ?? []
                self.activityIndicator.stopAnimating()
            }
        }
        // Creates a serial queue
        OperationQueue.main.maxConcurrentOperationCount = 1
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at \(indexPath.row)")
        
        self.performSegue(withIdentifier: TweetDetailViewController.identifier, sender: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetNibCell.identifier, for: indexPath) as! TweetNibCell
    
        let tweet = self.allTweets[indexPath.row]
        cell.tweet = tweet
        
        return cell
    }
    
}
