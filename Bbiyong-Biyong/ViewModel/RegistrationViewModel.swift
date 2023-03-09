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
        
        if let _ = Int(str) {
            return true
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
        UserDefaults.standard.setValue(true, forKey: "launchedBefore")
        UserDefaults.standard.setValue(Date(), forKey: "firstRegisteredDate")
        UserDefaults.standard.setValue(username!, forKey: "username")
        UserDefaults.standard.setValue(Int(maximumCostString!)!, forKey: "maximum")
    }
}
