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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self

        JSONParser.tweetsFrom(data: JSONParser.sampleJSONData) { (success, tweets) in
            if (success) {
                guard let tweets = tweets else { fatalError("Tweets came back nil") }
                
                for tweet in tweets {
                    print(tweet.text)
                    Tweets.shared.addTweet(tweet: tweet)
                }
            }
            
        }
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
//    var tweetArray = [String]()
//    
//    let filePath = Bundle.main.path(forResource: "tweet", ofType: "json")
//    let path = filePath
//         tweetArray = NSArray(contentsOf: path)
//    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at \(indexPath.row)")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Tweets.shared.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let tweet = Tweets.shared.getTweetAt(index: indexPath.row)
        cell.textLabel?.text = tweet.text
        cell.detailTextLabel?.text = tweet.user?.name
        
        
        return cell
    }
}
