//
//  NotificationViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/04/14.
//

import UIKit
import SnapKit

class NotificationViewController: UIViewController {
    // MARK: - Properties
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
    
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyNotificationSwitch.addTarget(self, action: #selector(updateNotificationSetting), for: .valueChanged)
        monthlyNotificationSwitch.addTarget(self, action: #selector(updateNotificationSetting), for: .valueChanged)
        
        configure()
    }
    
    // MARK: - Actions
    @objc func updateNotificationSetting(_ sender: UISwitch) {
        if sender.isOn {
            let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .sound)
            
            userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
                if success {
                    if sender == self.dailyNotificationSwitch {
                        DispatchQueue.main.async {
                            self.sendDailyNotification(baseTime: self.datePicker.date)
                        }
                    } else {
                        self.sendMonthlyNotification()
                    }
                } else {
                    if let error {
                        print("Notification Error: ", error)
                    }
                }
            }
            
        } else {
            if sender == dailyNotificationSwitch {
                userNotificationCenter.removePendingNotificationRequests(withIdentifiers: ["dailyNoti"])
                print("Notification: 매일 알림 취소")
            } else {
                userNotificationCenter.removePendingNotificationRequests(withIdentifiers: ["monthlyNoti"])
                print("Notification: 매월 1일 알림 취소")
            }
        }
    }

    // MARK: - Helpers
    func configure() {
        view.backgroundColor = .systemBackground
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
    
    func sendDailyNotification(baseTime: Date) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "\(Date().day)일의 삐용비용을 입력할 시간!"
        notificationContent.body = "오늘 하루 감정 소비를 기록해주세요"
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = baseTime.hour
        dateComponents.minute = baseTime.minute

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        
        let request = UNNotificationRequest(identifier: "dailyNoti",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error {
                print("Notification Error: ", error)
            }
        }
    }
    
    func sendMonthlyNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "\(Date().month)월의 소비한도 설정하기!"
        notificationContent.body = "이번 달은 최대 얼마의 삐용비용을 사용할까요?"
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.day = 1
        dateComponents.hour = 0
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        
        let request = UNNotificationRequest(identifier: "monthlyNoti",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error {
                print("Notification Error: ", error)
            }
        }
    }
}
