//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Sergelenbaatar Tsogtbaatar on 3/20/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit
import Foundation
import FoldingCell

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var cellHeights = (100..<280).map { _ in C.CellHeight.close }
    
    var allTweets = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var userProfile: User?
  
    fileprivate struct C {
        struct CellHeight {
            static let close: CGFloat = 100 // equal or greater foregroundView height
            static let open: CGFloat = 280 // equal or greater containerView height
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationController?.delegate = self
        
        
        let tweetNib = UINib(nibName: "MyFoldingCell", bundle: Bundle.main)
        self.tableView.register(tweetNib, forCellReuseIdentifier: MyFoldingCell.identifier)
//        let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil)
//        self.tableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
        
        self.navigationItem.title = "My Timeline"
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        setUpNavigationBarItems()
        updateTimeline()
        
    }
    private func setUpNavigationBarItems() {
        setUpTitleImage()
        setUpProfileButton()
       
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setUpTitleImage() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "title_icon"))
        navigationItem.titleView = titleImageView
        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        titleImageView.contentMode = .scaleAspectFit
    }
    
    func test() {
        performSegue(withIdentifier: ProfileViewController.identifier, sender: nil)
    }
    
    private func setUpProfileButton() {
        let profileButton = UIButton(type: .system)
        profileButton.addTarget(self, action: #selector(HomeTimelineViewController.test), for: .touchUpInside)
        profileButton.setImage(#imageLiteral(resourceName: "meIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        profileButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileButton)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? FoldingCell {
            if cellHeights[indexPath.row] == C.CellHeight.close {
                cell.selectedAnimation(false, animated: false, completion: nil)
            } else {
                cell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at \(indexPath.row)")
        
//        self.performSegue(withIdentifier: TweetDetailViewController.identifier, sender: nil)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? FoldingCell else {
            return
        }
        var duration = 0.0
        if cellHeights[indexPath.row] == 100 {
            cellHeights[indexPath.row] = 280
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            // close
            cellHeights[indexPath.row] = 100
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: { 
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: TweetNibCell.identifier, for: indexPath) as! TweetNibCell
        let cell = tableView.dequeueReusableCell(withIdentifier: MyFoldingCell.identifier, for: indexPath) as! MyFoldingCell
        
        let tweet = self.allTweets[indexPath.row]
//        cell.tweet = tweet
        
        return cell
    }
    
}
