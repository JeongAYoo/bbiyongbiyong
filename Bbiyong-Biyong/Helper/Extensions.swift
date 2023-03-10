//
//  Extensions.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/18.
//

import UIKit

extension UIColor {
    static let boldGreen = UIColor(named: "BoldGreen")
    static let sageGreen = UIColor(red: 189/255, green: 210/255, blue: 182/255, alpha: 1)
    static let darkGreen = UIColor(red: 60/255, green: 98/255, blue: 85/255, alpha: 1)
    static let lightOrange = UIColor(red: 255/255, green: 192/255, blue: 144/255, alpha: 1)
    static let yellowBeige = UIColor(red: 255/255, green: 251/255, blue: 245/255, alpha: 1)
}

extension Date {
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    public var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
//    func toString() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
//        dateFormatter.locale = Locale.current
//        return dateFormatter.string(from: self)
//    }
}

//extension String {
//    func toDate() -> Date {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
//        dateFormatter.locale = Locale.current
//        return dateFormatter.date(from: self)!
//    }
//}

extension Int {
    func numberToCurrency() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: self))! + "원"
    }
}
