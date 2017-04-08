//
//  MyFoldingCell.swift
//  TwitterClient
//
//  Created by Cathy Oun on 4/7/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit
import FoldingCell

class MyFoldingCell: FoldingCell {

    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        // durations count equal it itemCount
        let durations = [0.2, 0.26, 0.2] // timing animation for each view
        return durations[itemIndex]
    }

}
