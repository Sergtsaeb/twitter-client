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
            UIImage.fetchImageWith((user?.profileImageURL)!) { (profilePic) in
                self.profileImageView.image = profilePic
            }
        
        }
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
