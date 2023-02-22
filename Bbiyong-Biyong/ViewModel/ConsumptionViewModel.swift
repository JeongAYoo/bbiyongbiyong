//
//  ComposeViewModel.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/20.
//

import Foundation

struct ConsumptionViewModel {
    var date: Date?
    var title: String?
    var cost: String?
    var content: String?
    
    var titleIsValid: Bool {
        return title?.isEmpty == false && title!.count <= 10
    }
    
    var costIsValid: Bool {
        guard let str = cost else { return false }
        
        if let _ = Int(str) {
            return true
        } else {
            return false
        }
    }
    
    var formIsValid: Bool {
        return titleIsValid && costIsValid
    }
}

