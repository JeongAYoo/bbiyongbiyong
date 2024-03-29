//
//  RegistrationModel.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/12.
//

import UIKit

struct RegistrationViewModel {
    var username: String?
    var maximumCostString: String?
    
    var nameIsValid: Bool {
        return username?.isEmpty == false && username!.count < 9
    }
    
    var numberIsValid: Bool {
        guard let str = maximumCostString else { return false }
        
        if let num = Int(str) {
            return num > 0 ? true : false
        } else {
            return false
        }
    }
    
    var formIsValid: Bool {
        return nameIsValid == true && numberIsValid
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor(named: "BoldGreen")! : UIColor(named: "BoldGreen")!.withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
    var usernameValidationLabelText: String {
        return nameIsValid ? "" : "8글자 이하로 입력해주세요."
    }
    
    var costValidationLabelText: String {
        return numberIsValid ? "" : "숫자만 입력해주세요."
    }
    
    func signUp() {
        FirstLaunch.launchedBefore = true
        RegisterDate.firstRegisteredDate = Date()
        UserName.username = username!
        MaximumCost.maximum = Int(maximumCostString!)!
    }
    
    func update() {
        UserName.username = username!
        MaximumCost.maximum = Int(maximumCostString!)!
    }
}
