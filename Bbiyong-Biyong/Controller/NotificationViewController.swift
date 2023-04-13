//
//  NotificationViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/04/14.
//

import UIKit
import SnapKit

class NotificationViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "매일 알림"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 소비 기록을 잊지 않도록 알려드려요"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        picker.date = Date()
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "ko_KR")
        picker.timeZone = .autoupdatingCurrent
        picker.tintColor = .boldGreen
        picker.contentHorizontalAlignment = .leading
        picker.minuteInterval = 10
        return picker
    }()
    
    private let dailyNotificationSwitch: UISwitch = {
        let modeSwitch = UISwitch()
        modeSwitch.onTintColor = .systemGreen
        modeSwitch.contentHorizontalAlignment = .trailing
        return modeSwitch
    }()
    
    private lazy var upperStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [datePicker, dailyNotificationSwitch])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private let secondTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "매월 1일"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    private let secondSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이번달 소비한도 수정 알림"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        label.sizeToFit()
        
        return label
    }()
    
    private let monthlyNotificationSwitch: UISwitch = {
        let modeSwitch = UISwitch()
        modeSwitch.onTintColor = .systemGreen
        modeSwitch.contentHorizontalAlignment = .trailing
        return modeSwitch
    }()
    
    private lazy var lowerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [secondSubtitleLabel, monthlyNotificationSwitch])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    func configure() {
        [titleLabel, descriptionLabel, upperStackView, secondTitleLabel, lowerStackView].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        upperStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        secondTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(upperStackView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        lowerStackView.snp.makeConstraints { make in
            make.top.equalTo(secondTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
    }
}
