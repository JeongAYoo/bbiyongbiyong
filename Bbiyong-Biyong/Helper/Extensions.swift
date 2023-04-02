//
//  Extensions.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/18.
//

import UIKit

extension UIColor {
    static let boldGreen = UIColor(named: "BoldGreen")
    static let sageGreen = UIColor(named: "SageGreen")
    static let darkGreen = UIColor(named: "DarkGreen")
    static let selectionColor = UIColor(red: 3/255, green: 201/255, blue: 136/255, alpha: 1)
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

}

extension Int {
    func numberToCurrency() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: self))! + "원"
    }
}
