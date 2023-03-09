//
//  DayTableViewCell.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/18.
//

import UIKit
import SnapKit

class DayTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "DayTableViewCell"
    
    let emotionImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: EmotionImage[0])
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let costLabel: UILabel = {
        let label = UILabel()
        label.text = "가격"
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .right
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var upperStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, costLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [upperStackView, contentLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        
        return stackView
    }()
    
    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(emotionImageView)
        contentView.addSubview(rootStackView)
        contentView.backgroundColor = .systemBackground
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
                contentView.layer.borderWidth = 1
                contentView.layer.borderColor = UIColor.boldGreen?.cgColor
            } else {
                contentView.layer.borderWidth = 0
            }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        
        rootStackView.snp.makeConstraints { make in
            make.leading.equalTo(emotionImageView.snp.trailing).offset(20)
            make.top.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(20)
        }
        
        //let size = contentView.frame.size.height
        emotionImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(40)
        }
    }

}
