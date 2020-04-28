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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var specialPriceLabel: UILabel!
    @IBOutlet weak var eventStackView: UIStackView!
    
    func setImageFromData(data: Data) {
        DispatchQueue.main.async {
            self.menuImageView.image = UIImage(data: data)
            self.menuImageView?.layer.cornerRadius = (self.menuImageView?.frame.height)! / 2
        }
    }
    
    func configuration(info: SideDishInfo) {
        setTitle(text: info.title)
        setDescription(text: info.description)
        setOriginPriceLabel(text: info.originalPrice)
        setSpecialPriceLabel(text: info.specialPrice)
        setEventStackView(badges: info.badges)
    }
    
    private func setTitle(text title: String) {
        titleLabel.text = title
    }
    
    private func setDescription(text description: String) {
        descriptionLabel.text = description
    }
    
    private func setOriginPriceLabel(text original: String?) {
        if let original = original {
            let originPrice = original
            let attributedString = NSMutableAttributedString(string: originPrice)
            attributedString.addAttribute(.baselineOffset, value: 0, range: (originPrice as NSString).range(of: originPrice))
            attributedString.addAttribute(.strikethroughStyle, value: 1, range: (originPrice as NSString).range(of: originPrice))
            
            self.originalPriceLabel.attributedText = attributedString
        } else {
            originalPriceLabel.isHidden = true
        }
    }
    
    private func setSpecialPriceLabel(text special: String) {
        specialPriceLabel.text = special
    }
    
    private func setEventStackView(badges: [Badge]?) {
        guard let badges = badges, badges.count > 0 else {return}
        
        badges.forEach {
            let label = PaddingLabel()
            label.text = $0.name
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = .white
            label.textAlignment = .center
            label.backgroundColor = UIColor(hex: $0.color)
            eventStackView.addArrangedSubview(label)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        originalPriceLabel.isHidden = false
        for subview in eventStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
}
