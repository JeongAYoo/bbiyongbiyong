//
//  CustomTextField.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/12.
//

import UIKit
import SnapKit

class CustomTextField: UITextField {

    init(placeholder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()   // 왼쪽 공백
        spacer.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(12)
        }
        
        leftView = spacer
        leftViewMode = .always
        borderStyle = .roundedRect
        textColor = .label
        keyboardType = .default
        backgroundColor = UIColor.secondarySystemBackground
        
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.gray])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
