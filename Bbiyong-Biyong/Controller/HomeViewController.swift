//
//  ViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/11.
//

import UIKit
import SnapKit
import RealmSwift

final class HomeViewController: UIViewController {
    // MARK: - Properties
    var scrollView = UIScrollView()
    var contentView = HomeView()
    
    let tasks = Consumption.findAll()
    var monthlyTotalCost = 0

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        calculateMonthlyTotal()
    }
    
    // MARK: - Actions
    
    @objc func addButtonTapped() {
        let composeVC = UINavigationController(rootViewController: ComposeViewController())
        composeVC.modalPresentationStyle = .fullScreen
        present(composeVC, animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.width.centerX.equalTo(scrollView.frameLayoutGuide)
            make.top.bottom.equalTo(scrollView.contentLayoutGuide)
        }
        
        // configure NavigationBar
        navigationItem.title = "삐용비용"
        let boldLargeConfig = UIImage.SymbolConfiguration(pointSize: UIFont.buttonFontSize, weight: .bold, scale: .large)
        let plusImage = UIImage(systemName: "plus", withConfiguration: boldLargeConfig)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemGreen
    }
    
    func calculateMonthlyTotal() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let thisMonth = dateFormatter.string(from: Date())
        let monthlyTotal: () = tasks.filter {
            return dateFormatter.string(from: $0.date) == thisMonth
        }.forEach {
            monthlyTotalCost += $0.cost
        }
        
        contentView.totalConsumptionLabel.text = "\(monthlyTotalCost) 원"
    }

}

