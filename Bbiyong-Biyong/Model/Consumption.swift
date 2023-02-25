//
//  Consumption.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/20.
//

import Foundation
import RealmSwift

class Consumption: Object {
    @Persisted(primaryKey: true) var _id: ObjectId

    @Persisted var date: Date = Date()
    @Persisted var title: String = ""
    @Persisted var cost: Int = 0
    @Persisted var content: String = ""
}

extension Consumption {
    private static var realm = try! Realm()
    
    static func findAll() -> Results<Consumption> {
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        return realm.objects(Consumption.self)
    }
    
    static func addConsumption(_ consumption: Consumption) {
        try! realm.write {
            realm.add(consumption)
        }
    }
    
    static func deleteConsumption(_ consumption: Consumption) {
        try! realm.write {
            realm.delete(consumption)
        }
    }
    
    static func editConsumption(consumption: Consumption, date: Date, title: String, cost: Int, content: String) {
        try! realm.write {
            consumption.date = date
            consumption.title = title
            consumption.cost = cost
            consumption.content = content
        }
    }
}
