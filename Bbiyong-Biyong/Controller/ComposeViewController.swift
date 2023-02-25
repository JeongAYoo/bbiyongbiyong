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
        configureUI()
        setTarget()
        bind()
    }
    
    // MARK: - Actions
    @objc func cancel() {
        dismiss(animated: true)
    }
    
    @objc func save() {
        
    }
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        viewModel.date.value = sender.date
    }
    
    @objc func titleTextFieldDidChange(_ sender: UITextField) {
        // 첫글자로 공백이 입력되면 지우기
        if sender.text?.count == 1 {
            if sender.text?.first == " " {
                sender.text = ""
                return
            }
        }
        viewModel.title.value = sender.text ?? ""
    }
    
    @objc func costTextFieldDidChange(_ sender: UITextField) {
        viewModel.cost.value = sender.text ?? ""
    }
    
    // MARK: - Helpers
    func configureUI() {
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
        
    }
    
    func setTarget() {
        composeView.datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        composeView.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        composeView.costTextField.addTarget(self, action: #selector(costTextFieldDidChange(_:)), for: .editingChanged)
        // TODO: - 텍스트뷰
    }
    
    func bind() {
        viewModel.date.bind { date in
            self.composeView.datePicker.date = date
        }
        
        viewModel.title.bind { text in
            print(text)
            self.composeView.titleTextField.text = text
        }
        
        viewModel.cost.bind { text in
            self.composeView.costTextField.text = text
        }
        
        viewModel.content.bind { text in
            self.composeView.contentTextView.text = text
        }
        
    }

}
