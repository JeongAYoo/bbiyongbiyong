//
//  CalendarViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/15.
//

import UIKit
import FSCalendar
import SnapKit

final class CalendarViewController: UIViewController {
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
        calendar.appearance.titleWeekendColor = .lightOrange
        calendar.appearance.weekdayTextColor = .darkGreen
        calendar.appearance.todayColor = .boldGreen
        calendar.appearance.selectionColor = .sageGreen
        
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
