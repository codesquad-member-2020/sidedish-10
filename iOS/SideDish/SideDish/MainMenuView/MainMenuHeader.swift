//
//  MainMenuHeader.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/24.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

protocol SectionTapped: class {
    func sectionTapped(headerView: MainMenuHeader, at section: Int, title: String)
}

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
    
    var index: Int!
    weak var delegate: SectionTapped?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLayout()
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
    }
    
    @objc func tapped(_ recognizer: UITapGestureRecognizer) {
        guard let title = titleLabel.text else { return }
        delegate?.sectionTapped(headerView: self, at: index, title: title)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureLayout()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
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
    
    func setTitleLabel(text: String) {
        self.titleLabel.text = text
    }
    
    func setContentLabel(text: String) {
        self.contentLabel.text = text
    }
}
