//
//  SettingTableViewCell.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/18.
//

import UIKit
import SnapKit

final class SettingTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "SettingTableViewCell"
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
//    private let detailLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.textColor = .darkGray
//        label.textAlignment = .right
//        return label
//    }()
    
    private var subtextLabel: UILabel!
    
    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
//        contentView.addSubview(detailLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size.height - 12
        iconContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(size)
        }
        
        let imageSize = size / 1.5
        iconContainer.center = iconContainer.center
        iconImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(imageSize)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.height.equalToSuperview()
            make.leading.equalTo(iconContainer.snp.trailing).offset(20)
            //make.trailing.equalToSuperview().offset(10)
        }
        
//        detailLabel.snp.makeConstraints { make in
//            make.centerY.height.equalToSuperview()
//            make.trailing.equalTo(contentView).inset(10)
//        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // reset
        iconImageView.image = nil
        titleLabel.text = nil
        iconContainer.backgroundColor = nil
    }
    
    public func configure(with model: SettingsOption) {
        titleLabel.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor

        if model.title == "버전" {
            subtextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: self.frame.height))
            subtextLabel.text = Utils.getAppVersion()
            subtextLabel.textColor = .lightGray
            subtextLabel.textAlignment = .right
            subtextLabel.sizeToFit()
            self.accessoryView = subtextLabel
        }
    }
    
    func setFonts() {
        titleLabel.font = UIFont().customTextFont
        guard let subtext = subtextLabel else { return }
        subtext.font = UIFont().customTextFont
    }
}
