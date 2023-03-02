//
//  CalendarViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/15.
//

import UIKit
import FSCalendar
import SnapKit
import RealmSwift

final class CalendarViewController: UIViewController {
    // MARK: - Properties
    private var calendarView: FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
        
        calendar.placeholderType = .fillHeadTail
        calendar.backgroundColor = .systemBackground
        calendar.layer.cornerRadius = 10
        // shadow
        calendar.layer.shadowOffset = CGSize(width: 0, height: 5)
        calendar.layer.shadowRadius = 8
        calendar.layer.shadowOpacity = 0.2
        
        // calendar header
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleColor = .label
        calendar.appearance.headerTitleAlignment = .center
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 18)
        calendar.headerHeight = 40.0
        
        // weekdays, numbers Font
        calendar.appearance.weekdayFont = .systemFont(ofSize: 15)
        calendar.appearance.titleFont = .systemFont(ofSize: 16)
        
        // color
        calendar.appearance.titleDefaultColor = .label
        calendar.appearance.titleWeekendColor = .lightOrange
        calendar.appearance.weekdayTextColor = .darkGreen
        calendar.appearance.todayColor = .boldGreen
        calendar.appearance.selectionColor = .sageGreen
        calendar.appearance.eventDefaultColor = .systemGreen
        
        return calendar
    }()
    
    private lazy var header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
    private let headerLabel = UILabel()
    private let headerDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "d일 EEEE"
        return formatter
    }()
    
    private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(DayTableViewCell.self, forCellReuseIdentifier: DayTableViewCell.identifier)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        return table
    }()
    
    var tasks: Results<Consumption>!
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.delegate = self
        calendarView.dataSource = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
        
        tasks = Consumption.fetchDate(date: Date())
        
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .sageGreen
        navigationItem.title = "기록"
        
        // calendarView
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.snp.centerY).offset(50)
        }
        
        // tableView
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
                
        // tableView header
        headerLabel.text = headerDateFormatter.string(from: Date())
        headerLabel.font = .boldSystemFont(ofSize: 18)
        header.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }
        
        tableView.tableHeaderView = header
        
        //tableView footer
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        let addButton = AddNewButton(frame: .zero, type: .detail)
        footer.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
        }
        
        tableView.tableFooterView = footer
    }
    
}

// MARK: - UITableViewDataSource
extension CalendarViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DayTableViewCell.identifier, for: indexPath) as? DayTableViewCell else { return UITableViewCell() }
        cell.costLabel.text = numberFormatter(number: tasks[indexPath.row].cost)
        cell.titleLabel.text = tasks[indexPath.row].title
        cell.contentLabel.text = tasks[indexPath.row].content
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension CalendarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - FSCalendarDelegate
extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.snp.centerY).offset(10)
        }
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        
        switch dateFormatter.string(from: date) {
        case dateFormatter.string(from: Date()):
            return "오늘"
        default:
            return nil
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        headerLabel.text = headerDateFormatter.string(from: date)
        tasks = Consumption.fetchDate(date: date)
        tableView.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return Consumption.fetchDate(date: date).count
    }
}
