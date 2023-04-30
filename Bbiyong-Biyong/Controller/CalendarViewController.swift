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
        calendar.scope = .month
        
        calendar.placeholderType = .fillHeadTail
        calendar.backgroundColor = .secondarySystemGroupedBackground
        calendar.layer.cornerRadius = 10
        
        // calendar header
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleColor = .label
        calendar.appearance.headerTitleAlignment = .center
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.headerHeight = 40.0
        
        // color
        calendar.appearance.titleDefaultColor = .label
        calendar.appearance.titleWeekendColor = .lightOrange
        calendar.appearance.weekdayTextColor = .darkGreen
        calendar.appearance.todayColor = .boldGreen
        
        calendar.appearance.selectionColor = .selectionColor
        calendar.appearance.eventDefaultColor = .boldGreen
        calendar.appearance.eventSelectionColor = .selectionColor
        
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
    
    var tasks: Results<Consumption>! {
        didSet {
            tableView.reloadData()
        }
    }
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        let defaultDate = calendarView.selectedDate ?? calendarView.today!
        tasks = Consumption.fetchDate(date: defaultDate)
        calendarView.reloadData()
        setFonts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.delegate = self
        calendarView.dataSource = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 75
        
        tasks = Consumption.fetchDate(date: Date())
        
        configureUI()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    // MARK: - Actions
    @objc func addButtonTapped() {
        let vc = ComposeViewController()
        vc.viewModel.date.value = calendarView.selectedDate ?? Date()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc func swipeEvent(_ swipe: UISwipeGestureRecognizer) {
        if swipe.direction == .up {
            calendarView.scope = .week
        }
        else if swipe.direction == .down {
            calendarView.scope = .month
        }
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
            make.height.equalTo(view.frame.height / 2.3)
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
        header.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }
        
        tableView.tableHeaderView = header
        
        //tableView footer
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        let addButton = AddNewButton(frame: .zero, type: .detail)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        footer.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
        }
        
        tableView.tableFooterView = footer
    }
    
    // change calendar, tableview header label font
    func setFonts() {
        calendarView.appearance.headerTitleFont = UIFont().customContentFont
        
        // weekdays, numbers Font
        calendarView.appearance.weekdayFont = UIFont().customSmallTextFont
        calendarView.appearance.titleFont = UIFont().customFont(ofSize: 16)
        
        headerLabel.font = UIFont().customFont(ofSize: 18, isBold: true)
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
        cell.selectionStyle = .none
        cell.costLabel.text = tasks[indexPath.row].cost.numberToCurrency()
        cell.titleLabel.text = tasks[indexPath.row].title
        cell.contentLabel.text = tasks[indexPath.row].content
        cell.emotionImageView.image = UIImage(named: tasks[indexPath.row].emotion)
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension CalendarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ComposeViewController()
        vc.originalTarget = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UIScrollViewDelegate
extension CalendarViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y <= 0 {
            calendarView.scope = .month
        } else {
            calendarView.scope = .week
        }
    }
}

// MARK: - FSCalendarDelegate
extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarView.snp.updateConstraints { make in
            make.height.equalTo(bounds.height)
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
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return Consumption.fetchDate(date: date).count
    }
}
