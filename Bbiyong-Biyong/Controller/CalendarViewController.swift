//
//  CalendarViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/15.
//

import UIKit
import FSCalendar
import SnapKit

class CalendarViewController: UIViewController {
    // MARK: - Properties
    private var calendarView: FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
        
        calendar.placeholderType = .fillHeadTail
        calendar.layer.cornerRadius = 10
        
        // header
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleColor = .label
        calendar.appearance.headerTitleAlignment = .center
        calendar.headerHeight = 40.0
        
        // color
        calendar.backgroundColor = UIColor(red: 255/255, green: 251/255, blue: 245/255, alpha: 1)
        calendar.appearance.titleWeekendColor = UIColor(red: 121/255, green: 135/255, blue: 119/255, alpha: 1)
        calendar.appearance.weekdayTextColor = UIColor(red: 162/255, green: 178/255, blue: 159/255, alpha: 1)
        calendar.appearance.todayColor = UIColor(named: "BoldGreen")
        calendar.appearance.selectionColor = UIColor(red: 189/255, green: 210/255, blue: 182/255, alpha: 1)
        
        return calendar
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemBackground
        
    }
    
    func configureCalendar() {
        calendarView.delegate = self
        calendarView.dataSource = self
        
        view.addSubview(calendarView)
        
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.snp.centerY)
        }
    }
    
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.snp.centerY).offset(10)
        }
        self.view.layoutIfNeeded()
    }
}
