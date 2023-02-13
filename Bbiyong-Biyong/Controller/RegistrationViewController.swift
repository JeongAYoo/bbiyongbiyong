//
//  RegistrationViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/12.
//

import UIKit

final class RegistrationViewController: UIViewController {
    // MARK: - Properties
    
    private var viewModel = RegistrainViewModel()
    
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
        label.font = .boldSystemFont(ofSize: 14)
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
    
    private let maximumCostLabel: UILabel = {
        let label = UILabel()
        label.text = "이번 달 삐용비용"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = UIColor(named: "BoldGreen")

        return label
    }()
    
    private let maximumCostTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "이번 달 최대 한도 금액")
        tf.keyboardType = .numberPad
        return tf
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "* 이번 달 감정소비 비용으로 쓸 최대 금액 한도를 입력해주세요."
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)

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
        let stackView = UIStackView(arrangedSubviews: [titleLabel, usernameLabel, usernameTextField, maximumCostLabel, maximumCostTextField, detailLabel, signUpButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.setCustomSpacing(20, after: titleLabel)
        stackView.setCustomSpacing(40, after: detailLabel)
        
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
        let navVC = UINavigationController(rootViewController: MainViewController())
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == usernameTextField {
            viewModel.username = sender.text
        } else {
            viewModel.maximumCostString = sender.text
        }
        
        updateForm()
    }
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
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
