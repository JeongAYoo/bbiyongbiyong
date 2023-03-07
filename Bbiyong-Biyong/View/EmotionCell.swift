//
//  EmotionCell.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/03/07.
//

import UIKit
import SnapKit

final class EmotionCell: UICollectionViewCell {
    // MARK: - Property
    static let identifier = "EmotionCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helpers
    func configure() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = contentView.frame.height / 2
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.boldGreen?.cgColor
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setImage(imageName: String) {
        // String -> enum
        // imageView.image = UIImage(name: .imageName)
    }
}
