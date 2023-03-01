//
//  AddNewButton.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/19.
//

import UIKit

class AddNewButton: UIButton {
    enum ButtonType {
        case home
        case detail
    }

    init(frame: CGRect, type: ButtonType) {
        super.init(frame: frame)
        configure(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(type: ButtonType) {
        switch type {
        case .home:
            layer.cornerRadius = 20
            clipsToBounds = true
            tintColor = .white
            backgroundColor = .boldGreen
            setTitle("추가하기", for: .normal)

        case .detail:
            layer.cornerRadius = 25
            clipsToBounds = true
            layer.borderWidth = 1
            layer.borderColor = UIColor.lightGray.cgColor
            tintColor = .lightGray
            backgroundColor = .systemBackground
            setImage(UIImage(systemName: "plus"), for: .normal)
        }
    }
}
