//
//  RegistrationModel.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/12.
//

import UIKit

struct RegistrainViewModel {
    var username: String?
    var maximumCostString: String?
    
    var formIsValid: Bool {
        return username?.isEmpty == false && maximumCostString?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor(named: "BoldGreen")! : UIColor(named: "BoldGreen")!.withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}
