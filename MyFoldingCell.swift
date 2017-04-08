//
//  FoldingCell.swift
//  TwitterClient
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/7/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit
import FoldingCell

class MyFoldingCell: FoldingCell {

    
//    @IBOutlet weak var containerViewTop: NSLayoutConstraint!
//    
//    @IBOutlet weak var foregroundView: RotatedView!
//    
//    @IBOutlet weak var containerView: UIView!
//    
    
    @IBOutlet weak var label: UILabel!
    var tweet: Tweet? {
        didSet {
            if let tweet = tweet {
                label.text = tweet.text
            }
        }
    }
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
}

