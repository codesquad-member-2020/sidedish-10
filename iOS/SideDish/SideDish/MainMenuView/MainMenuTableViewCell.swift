//
//  MainMenuTableViewCell.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/21.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class MainMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var specialPriceLabel: UILabel!
    
    func configuration() {
        setOriginPriceLabel()
    }
    
    func setOriginPriceLabel() {
        let originPrice = "원가"
        let attributedString = NSMutableAttributedString(string: originPrice)
        attributedString.addAttribute(.baselineOffset, value: 0, range: (originPrice as NSString).range(of: originPrice))
        attributedString.addAttribute(.strikethroughStyle, value: 1, range: (originPrice as NSString).range(of: originPrice))
        
        self.originalPriceLabel.attributedText = attributedString
    }
    
    func setPadding(_ label: UILabel) {
        label
    }
}
