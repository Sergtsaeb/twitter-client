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

    @IBOutlet weak var tableView: UITableView!
    
    var allTweets = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        updateTimeline()

//        JSONParser.tweetsFrom(data: JSONParser.sampleJSONData) { (success, tweets) in
//            if (success) {
//                guard let tweets = tweets else { fatalError("Tweets came back nil") }
//                
//                for tweet in tweets {
//                    print(tweet.text)
//                    Tweets.shared.addTweet(tweet: tweet)
//                }
//            }
//            
//        }
        
    }
    
    func updateTimeline() {
        API.shared.getTweets { (tweets) in
            OperationQueue.main.addOperation {
                self.allTweets = tweets ?? []
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at \(indexPath.row)")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentTweet = allTweets[indexPath.row]
        
//      let tweet = Tweets.shared.getTweetAt(index: indexPath.row)
        cell.textLabel?.text = currentTweet.text
        cell.detailTextLabel?.text = currentTweet.user?.name
        
        return cell
    }
}
