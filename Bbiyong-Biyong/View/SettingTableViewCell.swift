//
//  SettingTableViewCell.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/18.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
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
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(label)
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

        label.snp.makeConstraints { make in
            make.centerY.height.equalToSuperview()
            make.leading.equalTo(iconContainer.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(10)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // reset
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
    }
    
    public func configure(with model: SettingsOption) {
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor

        if model.title == "버전" {
            let subtext = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: self.frame.height))
            subtext.text = Utils.getAppVersion()
            subtext.textColor = .lightGray
            subtext.textAlignment = .right
            subtext.sizeToFit()
            self.accessoryView = subtext
        }
    }

}
