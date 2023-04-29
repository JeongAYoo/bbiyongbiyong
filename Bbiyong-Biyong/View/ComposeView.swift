//
//  ComposeView.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/20.
//

import UIKit
import SnapKit

class ComposeView: UIView {

    // MARK: - Properties
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        picker.date = Date()
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ko_KR")
        picker.timeZone = .autoupdatingCurrent
        picker.tintColor = .boldGreen
        picker.contentHorizontalAlignment = .leading
        return picker
    }()
    
    lazy var emotionButton: UIButton = {
        let button = UIButton()        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.textColor = .darkGreen
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    let titleTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "제목을 입력해주세요.")
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.darkGreen?.cgColor
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        return tf
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.text = "금액"
        label.textColor = .darkGreen
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    let costTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "금액을 입력해주세요.")
        tf.keyboardType = .numberPad
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.darkGreen?.cgColor
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        return tf
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.textColor = .darkGreen
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    let contentTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.darkGreen?.cgColor
        tv.layer.cornerRadius = 8
        tv.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        // 스택의 남은 세로로 남은 공간을 채우도록
        tv.setContentHuggingPriority(.defaultLow, for: .vertical)
        tv.backgroundColor = .secondarySystemGroupedBackground
        return tv
    }()
    
    private lazy var upperStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [datePicker, emotionButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            upperStackView,
            titleLabel, titleTextField,
            costLabel, costTextField,
            contentLabel, contentTextView])
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.setCustomSpacing(20, after: datePicker)
        stackView.setCustomSpacing(40, after: costTextField)
        
        return stackView
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
        backgroundColor = .sageGreen
        
//        datePicker.snp.makeConstraints { make in
//            make.leading.equalTo(stackView)
//        }
        emotionButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
    
    func setFonts() {
        [titleLabel, costLabel, contentLabel].forEach { label in
            label.font = UIFont().customContentFont
        }
        
        titleTextField.font = UIFont().customTextFont
        costTextField.font = UIFont().customTextFont
        contentTextView.font = UIFont().customTextFont
    }
}
