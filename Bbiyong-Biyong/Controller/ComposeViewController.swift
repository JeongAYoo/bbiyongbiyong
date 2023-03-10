//
//  ComposeViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/15.
//

import UIKit

final class ComposeViewController: UIViewController {
    // MARK: - Properties
    private lazy var saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    private let composeView = ComposeView()
    var viewModel = ConsumptionViewModel()
    // 읽기 모드
    var originalTarget: Consumption?
    // 편집 모드
    var editTarget: Consumption?
    
    // MARK: - Life cycle
    override func loadView() {
        view = composeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setTargetActions()
        bind()
        checkMode()
    }
    
    // MARK: - Actions
    @objc func cancel() {
        dismiss(animated: true)
    }
    
    @objc func save() {
        // 수정할 내용이 있을 때
        if let target = editTarget {
            viewModel.edit(old: target)
            navigationController?.popViewController(animated: true)
        } else {
            viewModel.add()
            dismiss(animated: true)
        }
    }
    
    @objc func cancelEdit() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func edit() {
        //composeView.isUserInteractionEnabled = true
        composeView.datePicker.isUserInteractionEnabled = true
        composeView.emotionButton.isUserInteractionEnabled = true
        composeView.titleTextField.isUserInteractionEnabled = true
        composeView.costTextField.isUserInteractionEnabled = true
        composeView.contentTextView.isEditable = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelEdit))
        navigationItem.rightBarButtonItems = [saveBarButton]
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        editTarget = originalTarget
        updateForm()
    }
    
    @objc func deleteConsumption() {
        guard let target = originalTarget else { return }
        let alert = UIAlertController(title: "\(target.title)", message: "삐용비용을 삭제할까요?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] action in
            Consumption.deleteConsumption(target)
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        viewModel.date.value = sender.date
    }
    
    @objc func showEmotionSheet(_ sender: UIButton) {
        let vc = EmotionViewController()
        vc.delegate = self
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        self.present(vc, animated: true)
        
//        viewModel.emotion.value = sender.currentTitle ?? EmotionImage[0]
    }
    
    @objc func titleTextFieldDidChange(_ sender: UITextField) {
        if sender.text?.count == 1 {
            if sender.text?.first == " " {
                sender.text = ""
                return
            }
        }
        viewModel.title.value = sender.text ?? ""
        updateForm()
    }
    
    @objc func costTextFieldDidChange(_ sender: UITextField) {
        viewModel.cost.value = sender.text ?? ""
        updateForm()
    }
    
    // MARK: - Helpers
    func checkMode() {
        if let consumption = originalTarget {
            navigationItem.title = "삐용비용"
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(edit)),
                UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteConsumption))
                                                  ]
            
            viewModel.date.value = consumption.date
            viewModel.title.value = consumption.title
            viewModel.cost.value = String(consumption.cost)
            viewModel.content.value = consumption.content
            viewModel.emotion.value = consumption.emotion
            
//            composeView.isUserInteractionEnabled = false
            composeView.datePicker.isUserInteractionEnabled = false
            composeView.emotionButton.isUserInteractionEnabled = false
            composeView.titleTextField.isUserInteractionEnabled = false
            composeView.costTextField.isUserInteractionEnabled = false
            composeView.contentTextView.isEditable = false
            composeView.contentTextView.isScrollEnabled = true
            
        } else {
            navigationItem.title = "새 소비 작성"
            navigationItem.rightBarButtonItem = saveBarButton
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        }
    }
    
    func configureUI() {
        // navigation
        navigationController?.navigationBar.tintColor = .systemGreen

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
    
    func setTargetActions() {
        composeView.datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        composeView.emotionButton.addTarget(self, action: #selector(showEmotionSheet), for: .touchUpInside)
        composeView.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        composeView.costTextField.addTarget(self, action: #selector(costTextFieldDidChange(_:)), for: .editingChanged)
        composeView.contentTextView.delegate = self
    }
    
    func bind() {
        viewModel.date.bind { date in
            self.composeView.datePicker.date = date
        }
        
        viewModel.title.bind { text in
            self.composeView.titleTextField.text = text
        }
        
        viewModel.cost.bind { text in
            self.composeView.costTextField.text = text
        }
        
        viewModel.content.bind { text in
            self.composeView.contentTextView.text = text
        }
        
        viewModel.emotion.bind { name in
            self.composeView.emotionButton.setBackgroundImage(UIImage(named: name), for: .normal)
        }
        
    }
    
    func updateForm() {
        let titleIsValid = viewModel.titleIsValid
        let costIsValid = viewModel.costIsValid
        saveBarButton.isEnabled = titleIsValid && costIsValid
    }

}

// MARK: - UITextViewDelegate
extension ComposeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.content.value = textView.text ?? ""
        if textView.text.count > 200 {
            textView.deleteBackward()
        }
    }
}

// MARK: - SendDataDelegate
protocol SendDataDelegate {
    func reciveData(response: Int) -> Void
}

extension ComposeViewController: SendDataDelegate {
    func reciveData(response: Int) {
        viewModel.emotion.value = EmotionImage[response]
    }
}
