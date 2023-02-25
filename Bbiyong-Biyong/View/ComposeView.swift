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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.textColor = .darkGreen
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let titleTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "제목을 입력해주세요.")
        tf.backgroundColor = .darkGreen
        return tf
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.text = "금액"
        label.textColor = .darkGreen
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let costTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "금액을 입력해주세요.")
        tf.backgroundColor = .darkGreen
        return tf
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.textColor = .darkGreen
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    let contentTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.darkGreen.cgColor
        tv.layer.cornerRadius = 8
        tv.font = .systemFont(ofSize: 17)
        tv.contentInset = .init(top: 15, left: 20, bottom: 20, right: 20)
        // 스택의 남은 세로로 남은 공간을 채우도록
        tv.setContentHuggingPriority(.defaultLow, for: .vertical)
        return tv
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            datePicker,
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
        
        datePicker.snp.makeConstraints { make in
            make.leading.equalTo(stackView)
        }
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}
