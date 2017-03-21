//
//  Tweets.swift
//  TwitterClient
//
//  Created by Sergelenbaatar Tsogtbaatar on 3/20/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import Foundation

class Tweets {
    
    static let shared = Tweets()
    
    var tweetArray = [Tweet]()
    
    private init(){}
    
    func addTweet(tweet: Tweet) {
        self.tweetArray.append(tweet)
    }
    
    func count() -> Int {
        return self.tweetArray.count
    }
    
    func getTweetAt(index: Int) -> Tweet {
        return tweetArray[index]
    }
    
}
