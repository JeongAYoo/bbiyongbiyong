//
//  AddNewButton.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/19.
//

import UIKit

class AddNewButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = .boldGreen
        tintColor = .white
        setTitle("추가하기", for: .normal)
        setTitleColor(.systemGray, for: .highlighted)
        setImage(UIImage(systemName: "plus"), for: .normal)
        
    }
}
