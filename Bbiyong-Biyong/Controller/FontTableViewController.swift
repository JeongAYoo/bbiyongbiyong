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
    // 테스트용
    private var fontNames = ["시스템",
                             "나눔손글씨 꽃내음",
                             "나눔손글씨 무진장체",
                             "나눔손글씨 백의의 천사",
                             "나눔손글씨 성실체"]
    
    private var selectedIndex = UserDefaults.standard.integer(forKey: "selectedFontIndex")

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FontTableViewCell.self, forCellReuseIdentifier: FontTableViewCell.identifier)
        tableView.tableHeaderView = headerView
        tableView.allowsMultipleSelection = false
    }
    
    // MARK: - Helpers
    func applyFontToExampleText(index: Int) {
        if index == 0 {
            headerView.changeTextFont(font: .systemFont(ofSize: 20))
        } else {
            headerView.changeTextFont(font: UIFont(name: fontNames[index], size: 20)!)
        }
    }
    
    func saveFontIndex(index: Int) {
        UserDefaults.standard.set(index, forKey: "selectedFontIndex")   // 인덱스 저장
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
        if selectedIndex != indexPath.row {
            tableView.cellForRow(at: IndexPath(row: selectedIndex, section: 0))?.isSelected = false
            selectedIndex = indexPath.row
            
            applyFontToExampleText(index: indexPath.row)
            saveFontIndex(index: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == selectedIndex {
            cell.isSelected = true
            applyFontToExampleText(index: indexPath.row)
        }
    }
}
