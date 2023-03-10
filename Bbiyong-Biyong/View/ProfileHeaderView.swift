//
//  ProfileHeaderView.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/03/10.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    var username: String = UserDefaults.standard.string(forKey: "username") ?? "" {
        didSet {
            usernameLabel.text = "\(username)"
        }
    }
    
    var maximum: Int = UserDefaults.standard.integer(forKey: "maximum") {
        didSet {
            maximumLabel.text = "\(maximum.numberToCurrency())"
        }
    }
    
    private let profileIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.crop.circle")
        iv.tintColor = .boldGreen
        iv.setContentHuggingPriority(.defaultLow, for: .vertical)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let usernameStringLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    private let maximumStringLabel: UILabel = {
        let label = UILabel()
        label.text = "이번 달 한도"
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "\(username)"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var maximumLabel: UILabel = {
        let label = UILabel()
        label.text = "\(maximum.numberToCurrency())"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .right
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "highlighter"), for: .normal)
        button.contentHorizontalAlignment = .trailing
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
        let stack = UIStackView(arrangedSubviews: [editButton, profileIconImageView, upperLabelStack, lowerLabelStack])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(rootStack)

        rootStack.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.layer.frame.size).inset(20)
            make.bottom.equalToSuperview()
        }
        rootStack.layer.cornerRadius = 10
        rootStack.layer.masksToBounds = true
        rootStack.backgroundColor = .secondarySystemGroupedBackground
        rootStack.isLayoutMarginsRelativeArrangement = true
        rootStack.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
}
