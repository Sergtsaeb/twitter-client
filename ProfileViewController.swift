//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Sergelenbaatar Tsogtbaatar on 3/22/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User? {
        didSet {
            self.name.text = user?.name
            self.location.text = user?.location
            self.profileImageURL.text = user?.profileImageURL
        }
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var profileImageURL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        API.shared.getUserInfo { (user) in
            self.user = user
        }
    }

}
