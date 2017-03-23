//
//  API.swift
//  TwitterClient
//
//  Created by Sergelenbaatar Tsogtbaatar on 3/21/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import Foundation
import Accounts
import Social


//enum Callback {
//    case Accounts(ACAccount?)
//    case User(User?)
//    case Tweets([Tweet]?)
//}
//
//typealias babyGotBack = (Callback) -> ()


typealias AccountsCallback = (ACAccount?) -> ()
typealias UserCallback = (User?) -> ()
typealias TweetsCallback = ([Tweet]?) -> ()

class API {
    static let shared = API()
    
    var account: ACAccount?
    
    private func login(callback: @escaping AccountsCallback) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { (success, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                callback(nil)
                return //breaks out of the entire callback
            }
            
            if success {
                if let account = accountStore.accounts(with: accountType).first as? ACAccount {
                    callback(account)
                }
            } else {
                print("The user did not allow access to their account")
                callback(nil)
            }
        }
    }
    
    private func getOAuthUser(callback: @escaping UserCallback) {
        let url = URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {
            
            request.account = self.account
            
            request.perform(handler: { (data, response, error) in
                
                if let error = error {
                    print("Error: \(error)")
                    callback(nil)
                    return
                }
                
                guard let response = response else { callback(nil); return }
                guard let data = data else { callback(nil); return }
                
                switch response.statusCode {
                case 200...299:
                    print("Success: \(response.statusCode) \(data.description)")
                case 300...399:
                    print("Error: response came back with statusCode: \(response.statusCode)")
                case 400...499:
                    print("Error: response came back with statusCode: \(response.statusCode)")
                case 500...599:
                    print("Error: response came back with statusCode: \(response.statusCode)")
                default:
                    print("Error: response came back with statusCode: \(response.statusCode)")
                    callback(nil)
                }
                
            })
        }
        
        
    }
    
    private func updateTimeline(callback: @escaping TweetsCallback) {
        
        let url = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {
            
            request.account = self.account
            
            request.perform(handler: { (data, response, error) in
                
                if let error = error {
                    print("Error: Error requesting user's home timeline - \(error.localizedDescription)")
                    callback(nil)
                    return
                }
                
                guard let response = response else { callback(nil); return }
                guard let data = data else { callback(nil); return }
                
                if response.statusCode >= 200 && response.statusCode < 300 {
                    
                    JSONParser.tweetsFrom(data: data, callback: { (success, tweets) in
                        if success {
                            callback(tweets)
                        }
                    })
                    
                } else {
                    print("Something else went terribly wrong! We have a status code outside 200-299")
                    callback(nil)
                }
                
            })
        }
        
    }
    
    func getTweets(callback: @escaping TweetsCallback) {
        if self.account == nil {
            login(callback: { (account) in
                if let account = account {
                    self.account = account
                    self.updateTimeline(callback: callback)
//                    self.updateTimeline(callback: { (tweets) in
//                        callback(tweets)
//                    })
                }
            })
        } else {
            self.updateTimeline(callback: callback)
        }
    }
    
    func getUserInfo(callback: @escaping UserCallback) {
        self.getOAuthUser { (user) in
            callback(user)
        }
    }
    
}
