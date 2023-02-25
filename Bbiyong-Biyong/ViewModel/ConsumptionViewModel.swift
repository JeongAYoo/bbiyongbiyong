//
//  ComposeViewModel.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/20.
//

import Foundation

struct ConsumptionViewModel {
    var consumptions: [Consumption] = Array(Consumption.findAll())
    
    var date: Observable<Date> = Observable(Date())
    var title: Observable<String> = Observable("")
    var cost: Observable<String> = Observable("")
    var content: Observable<String> = Observable("")
    
    var titleIsValid: Bool {
        return title.value.isEmpty == false && title.value.count <= 10
    }
    
    var costIsValid: Bool {
        let str = cost.value
        
        if let _ = Int(str) {
            return true
        } else {
            return false
        }
    }
    
    var formIsValid: Bool {
        return titleIsValid && costIsValid
    }
    
    func add() {
        let new = Consumption()
        new.date = date.value
        new.title = title.value
        new.cost = Int(cost.value)!
        new.content = content.value
    }
}

