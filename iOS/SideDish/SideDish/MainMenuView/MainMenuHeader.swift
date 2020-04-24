//
//  MainMenuHeader.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/24.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class MainMenuHeader: UITableViewHeaderFooterView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    private let titleLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.setBorder(color: .gray, width: 1)
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLayout()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    private func configureLayout() {
        self.contentView.backgroundColor = UIColor(named: "HeaderBackgroundColor")
        self.contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentLabel)
    }
    
    func configureLabel(content: String) {
        let contents = content.components(separatedBy: "/")
        self.titleLabel.text = contents[0]
        self.contentLabel.text = contents[1]
    }
}
