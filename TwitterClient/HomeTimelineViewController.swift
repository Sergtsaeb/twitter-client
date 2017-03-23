//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Sergelenbaatar Tsogtbaatar on 3/20/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit
import Foundation

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
//    @IBAction func profile(_ sender: Any) {
//        
//        
//    }
    
    var allTweets = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My Timeline"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        updateTimeline()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "showDetailSegue" {
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                let selectedTweet = self.allTweets[selectedIndex]
                
                guard let destinationController = segue.destination as? TweetDetailViewController else { return }
                
                destinationController.tweet = selectedTweet
            }
            
            
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
    
    
   
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Selected row at \(indexPath.row)")
//        
////        if Tweet.init(json: "retweeted_status") == Tweet.retweeted_status {
////            
////        }
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
        if let cell = cell as? TweetCell {
            
            cell.tweetText?.text  = allTweets[indexPath.row].text
            
            let currentTweet = allTweets[indexPath.row]
            
            cell.textLabel?.text = currentTweet.text
            cell.detailTextLabel?.text = currentTweet.user?.name
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//    }

        
}
