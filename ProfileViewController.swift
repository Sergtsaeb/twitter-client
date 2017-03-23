//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Sergelenbaatar Tsogtbaatar on 3/22/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var profileImageURL: UILabel!
    
//    var name = profile.name
//    var location = User()?.location
//    var profileImgURL = User()?.profileImageURL
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUser()
    }
    
    
    func getUser() {
        API.shared.getUserInfo { (user) in
            OperationQueue.main.addOperation {
                self.user = user
                self.name.text = user?.name
                self.location.text = user?.location
                self.profileImageURL.text = user?.profileImageURL
            }
        }
    }

  

}
