//
//  DayTableViewCell.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/18.
//

import UIKit
import SnapKit

class DayTableViewCell: UITableViewCell {
    static let identifier = "DayTableViewCell"
    
    private let emotionImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "heart")
        iv.tintColor = .systemRed
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트"
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(emotionImageView)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.frame.size.height - 12
        emotionImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(size)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(emotionImageView.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

}
