//
//  ComposeViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/15.
//

import UIKit

final class ComposeViewController: UIViewController {
    // MARK: - Properties
    private let composeView = ComposeView()
    private var viewModel = ConsumptionViewModel()
    
    // MARK: - Life cycle
    override func loadView() {
        view = composeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Actions
    @objc func cancel() {
        dismiss(animated: true)
    }
    
    @objc func save() {
        
    }
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        
    }
    
    // MARK: - Helpers
    func configure() {
        // navigation
        navigationItem.title = "새 소비 작성"
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .systemBackground
        navigationBarAppearance.shadowColor = nil
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        
        composeView.datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    }

}
