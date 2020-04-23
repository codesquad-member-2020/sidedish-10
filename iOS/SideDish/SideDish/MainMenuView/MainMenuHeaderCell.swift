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
    
    func configuration(sectionInfo: String) {
        titleLabel.setBorder(color: .darkGray, width: 1)
        let sectionInfo = sectionInfo.components(separatedBy: "/")
        titleLabel.text = sectionInfo[0]
        contentsLabel.text = sectionInfo[1]
    }
}
