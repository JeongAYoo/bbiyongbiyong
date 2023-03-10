//
//  SettingViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/15.
//

import UIKit
import SnapKit
import AcknowList
import MessageUI

// MARK: - Model
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
    
    private lazy var headerView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 4))
    
    var model: [Section] = []
    
    var token: NSObjectProtocol?
    
    // MARK: - Life cycle
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        
        headerView.editButton.addTarget(self, action: #selector(showEditProfile), for: .touchUpInside)
        
        token = NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: OperationQueue.main, using: { noti in
            self.updateUserInfo()
        })
    }
    
    @objc func showEditProfile(_ sender: UIButton) {
        navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }
    
    func configureUI() {
        navigationItem.title = "설정"
        //navigationController?.navigationBar.prefersLargeTitles = true
        //tableView.backgroundColor = .sageGreen
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureData() {
        //        self.model.append(Section(title: "시스템", options: [
        //            .switchCell(model: SettingSwitchOption(title: "다크모드", icon: UIImage(systemName: "moon.fill"), iconBackgroundColor: .darkGray, isOn: true) {
        //
        //            }),
        //            .staticCell(model: SettingsOption(title: "알림", icon: UIImage(systemName: "bell.fill"), iconBackgroundColor: .systemPink) {
        //
        //            }),
        //            .staticCell(model: SettingsOption(title: "언어설정", icon: UIImage(systemName: "textformat"), iconBackgroundColor: .systemYellow) {
        //
        //            })
        //        ]))
        
        //        self.model.append(Section(title: "데이터", options: [
        //            .staticCell(model: SettingsOption(title: "백업 / 복구", icon: UIImage(systemName: "cloud"), iconBackgroundColor: .systemBlue) {
        //
        //            })
        //        ]))
        
        self.model.append(Section(title: "정보", options: [
            //            .staticCell(model: SettingsOption(title: "개인정보처리방침", icon: UIImage(systemName: "shield.fill"), iconBackgroundColor: .black) {
            //
            //            }),
            .staticCell(model: SettingsOption(title: "오픈소스 라이브러리", icon: UIImage(systemName: "books.vertical.fill"), iconBackgroundColor: .systemGreen) {
                let vc = AcknowListViewController()
                vc.navigationItem.title = "오픈소스 라이브러리"
                self.navigationController?.pushViewController(vc, animated: true)
            }),
            .staticCell(model: SettingsOption(title: "문의하기", icon: UIImage(systemName: "questionmark.circle.fill"), iconBackgroundColor: .systemBlue) {
                if MFMailComposeViewController.canSendMail() {
                    let vc = MFMailComposeViewController()
                    vc.mailComposeDelegate = self
                    
                    let bodyString = """
                                         문의 사항 및 의견을 작성해주세요.
                                         
                                         
                                         
                                         
                                         -------------------
                                         
                                         Device Model : \(Utils.getDeviceModelName())
                                         Device OS : \(UIDevice.current.systemVersion)
                                         App Version : \(Utils.getAppVersion())
                                         
                                         -------------------
                                         """
                    
                    vc.setToRecipients(["jadeyoo.ios@gmail.com"])
                    vc.setSubject("[삐용비용] 문의")
                    vc.setMessageBody(bodyString, isHTML: false)
                    
                    self.present(vc, animated: true, completion: nil)
                } else {
                    let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "'Mail' 앱을 찾을 수 없습니다.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인", style: .destructive, handler: nil)
                    sendMailErrorAlert.addAction(okAction)
                    self.present(sendMailErrorAlert, animated: true, completion: nil)
                }
            }),
            .staticCell(model: SettingsOption(title: "버전", icon: UIImage(systemName: "wand.and.rays.inverse"), iconBackgroundColor: .lightGray) {
                
            })
        ]))
    }
    
    func updateUserInfo() {
        headerView.username = UserDefaults.standard.string(forKey: "username")!
        headerView.maximum = UserDefaults.standard.integer(forKey: "maximum")
    }
    
}

// MARK: - UITableViewDataSource
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

// MARK: - UITableViewDelegate
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

extension SettingViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}
