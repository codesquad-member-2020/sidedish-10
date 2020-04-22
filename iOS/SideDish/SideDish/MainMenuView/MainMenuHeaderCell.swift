//
//  MainMenuHeaderCell.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/22.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class MainMenuHeaderCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: PaddingLabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    func configuration() {
        titleLabel.setBorder(color: .darkGray, width: 1)
    }
}
