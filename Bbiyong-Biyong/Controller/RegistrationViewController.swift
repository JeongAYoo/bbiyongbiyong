//
//  RegistrationViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/12.
//

import UIKit

final class RegistrationViewController: UIViewController {
    // MARK: - Properties
    
    private var viewModel = RegistrationViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 28)

        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = UIColor(named: "BoldGreen")

        return label
    }()
    
    private let usernameTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "이름 또는 닉네임")
        tf.textContentType = .username
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let usernameValidationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .systemRed

        return label
    }()
    
    private let maximumCostLabel: UILabel = {
        let label = UILabel()
        label.text = "이번 달 삐용비용"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = UIColor(named: "BoldGreen")

        return label
    }()
    
    private let maximumCostTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "이번 달 감정소비 금액 최대 한도")
        tf.keyboardType = .numberPad
        return tf
    }()
    
    private let costValidationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .systemRed

        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        button.backgroundColor = UIColor(named: "BoldGreen")!.withAlphaComponent(0.5)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, usernameLabel, usernameTextField, usernameValidationLabel, maximumCostLabel, maximumCostTextField, costValidationLabel, signUpButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.setCustomSpacing(30, after: titleLabel)
        stackView.setCustomSpacing(20, after: usernameValidationLabel)
        stackView.setCustomSpacing(40, after: costValidationLabel)
        
        return stackView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Action
    @objc func handleSignUp() {
        UserDefaults.standard.setValue(true, forKey: "launchedBefore")
        UserDefaults.standard.setValue(Date(), forKey: "firstRegisteredDate")
        
        let navVC = UINavigationController(rootViewController: MainViewController())
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        // 첫글자로 공백이 입력되면 지우기
        if sender.text?.count == 1 {
            if sender.text?.first == " " {
                sender.text = ""
                return
            }
        }
        
        if sender == usernameTextField {
            viewModel.username = sender.text
            usernameValidationLabel.text = viewModel.usernameValidationLabelText
        } else {
            viewModel.maximumCostString = sender.text
            costValidationLabel.text = viewModel.costValidationLabelText
        }
        
        updateForm()
    }
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    func configureNotificationObservers() {
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        maximumCostTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }

}
