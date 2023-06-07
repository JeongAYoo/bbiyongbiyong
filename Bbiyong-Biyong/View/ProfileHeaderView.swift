//
//  ProfileHeaderView.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/03/10.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    // MARK: - Properties
    var username: String = UserName.username {
        didSet {
            usernameLabel.text = "\(username)"
        }
    }
    
    var maximum: Int = MaximumCost.maximum {
        didSet {
            maximumLabel.text = "\(maximum.numberToCurrency())"
        }
    }
    
    private let profileIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.crop.circle")
        iv.tintColor = .boldGreen
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let usernameStringLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textAlignment = .left
        return label
    }()
    
    private let maximumStringLabel: UILabel = {
        let label = UILabel()
        label.text = "이번 달 한도"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "\(username)"
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        return label
    }()
    
    private lazy var maximumLabel: UILabel = {
        let label = UILabel()
        label.text = "\(maximum.numberToCurrency())"
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.tintColor = .boldGreen
        button.setImage(UIImage(systemName: "highlighter"), for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return button
    }()
    
    private lazy var upperLabelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [usernameStringLabel, usernameLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var lowerLabelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [maximumStringLabel, maximumLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var rootStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileIconImageView, upperLabelStack, lowerLabelStack])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 10

        return stack
    }()
    
    private var contentView = UIView()
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setFonts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configure() {
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self).inset(20).priority(.high)
            make.bottom.equalTo(self)
        }
        
        contentView.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.trailing.equalTo(contentView).inset(20)
        }
        
        contentView.addSubview(rootStack)
        rootStack.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(10)
            make.bottom.equalTo(contentView).inset(10)
            make.leading.trailing.equalTo(contentView).inset(20)
        }
    }
    
    func setFonts() {
        [usernameStringLabel, maximumStringLabel, usernameLabel, maximumLabel].forEach { label in
            label.font = UIFont().customTextFont
        }
    }
}
