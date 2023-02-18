//
//  SettingViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/15.
//

import UIKit
import SnapKit

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingSwitchOption)
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

struct SettingSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    var isOn: Bool
    let handler: (() -> Void)
}

final class SettingViewController: UIViewController {
    // MARK: - Properties
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        
        return table
    }()
    
    var model: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureUI()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureUI() {
        title = "설정"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    //(title: "다크모드", icon: UIImage(systemName: "moon.fill"), iconBackgroundColor: .darkGray)
    func configureData() {
        self.model.append(Section(title: "시스템", options: [
            .switchCell(model: SettingSwitchOption(title: "다크모드", icon: UIImage(systemName: "moon.fill"), iconBackgroundColor: .darkGray, isOn: true) {
                
            }),
            .staticCell(model: SettingsOption(title: "알림", icon: UIImage(systemName: "bell.fill"), iconBackgroundColor: .systemPink) {
                
            }),
            .staticCell(model: SettingsOption(title: "언어설정", icon: UIImage(systemName: "textformat"), iconBackgroundColor: .systemYellow) {
            
            })
        ]))
        
        self.model.append(Section(title: "데이터", options: [
            .staticCell(model: SettingsOption(title: "백업 / 복구", icon: UIImage(systemName: "cloud"), iconBackgroundColor: .systemBlue) {
                
            })
        ]))
        
        self.model.append(Section(title: "정보", options: [
            .staticCell(model: SettingsOption(title: "개인정보처리방침", icon: UIImage(systemName: "shield.fill"), iconBackgroundColor: .black) {
                
            }),
            .staticCell(model: SettingsOption(title: "오픈소스 라이브러리", icon: UIImage(systemName: "books.vertical.fill"), iconBackgroundColor: .systemGreen) {
                
            }),
            .staticCell(model: SettingsOption(title: "문의하기", icon: UIImage(systemName: "questionmark.circle.fill"), iconBackgroundColor: .systemBlue) {
                
            }),
            .staticCell(model: SettingsOption(title: "버전", icon: UIImage(systemName: "wand.and.rays.inverse"), iconBackgroundColor: .lightGray) {
                
            })
        ]))
    }
    
}

extension SettingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = model[indexPath.section].options[indexPath.row]
        
        switch data.self {
        case .staticCell(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
            cell.configure(with: data)
            return cell

        case .switchCell(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as? SwitchTableViewCell else { return UITableViewCell() }
            cell.configure(with: data)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = model[section]
        return section.title
    }
    
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let type = model[indexPath.section].options[indexPath.row]
        switch type.self {
        case .staticCell(let data):
            data.handler()
        case .switchCell(let data):
            data.handler()
            
        }
    }
}
