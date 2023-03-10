//
//  ComposeViewModel.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/20.
//

import Foundation

class ConsumptionViewModel {
    var consumptions: [Consumption] = Array(Consumption.findAll())
    
    var date: Observable<Date> = Observable(Date())
    var title: Observable<String> = Observable("")
    var cost: Observable<String> = Observable("")
    var content: Observable<String> = Observable("")
    var emotion: Observable<String> = Observable(EmotionImage[0])
    
    var titleIsValid: Bool {
        // 제목 최대 15글자
        if title.value.isEmpty == false {
            if title.value.count <= 15 {
                return true
            } else {
                title.value.removeLast()
                return true
            }
        } else {
            return false
        }
    }
    
    var costIsValid: Bool {
        // 소비 최대 9자리 숫자
        if cost.value.isEmpty {
            return false
        }
        
        if cost.value.count > 10 {
            cost.value.removeLast()
        }
        
        guard let _ = Int(cost.value) else {
            cost.value.removeAll()
            return false
        }
        
        return true
    }
    
    func add() {
        let new = Consumption()
        new.date = date.value
        new.title = title.value
        new.cost = Int(cost.value)!
        new.content = content.value
        new.emotion = emotion.value
        
        self.consumptions.append(new)
        Consumption.addConsumption(new)
    }
    
    func edit(old: Consumption) {
        Consumption.editConsumption(consumption: old, date: date.value, title: title.value, cost: Int(cost.value)!, content: content.value, emotion: emotion.value)
    }
}

