//
//  FontTableViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/04/02.
//

import UIKit

class FontTableViewController: UITableViewController {
    // MARK: - Properties
    private lazy var headerView = FontExampleHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 120))
    private var fontNames = ["기본 시스템 폰트",
                             "나눔손글씨 꽃내음",
                             "나눔손글씨 무진장체",
                             "나눔손글씨 백의의 천사",
                             "나눔손글씨 성실체"]

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FontTableViewCell.self, forCellReuseIdentifier: FontTableViewCell.identifier)
        tableView.tableHeaderView = headerView
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // the number of fonts
        return fontNames.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FontTableViewCell.identifier, for: indexPath) as! FontTableViewCell
        cell.fontNameLabel.text = fontNames[indexPath.row]
        if indexPath.row == 0 {
            cell.fontNameLabel.font = .systemFont(ofSize: 17)
        } else {
            cell.fontNameLabel.font = UIFont(name: fontNames[indexPath.row], size: 17)
        }

        return cell
    }

    // MARK: - Table view Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            headerView.changeTextFont(font: .systemFont(ofSize: 20))
        } else {
            headerView.changeTextFont(font: UIFont(name: fontNames[indexPath.row], size: 20)!)
        }
    }
}
