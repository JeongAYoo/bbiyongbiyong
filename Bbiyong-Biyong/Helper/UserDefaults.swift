//
//  UserDefaults.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/04/27.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct UserFont {
    @UserDefault(key: keyEnum.customFont.rawValue, defaultValue: CustomFont.system.rawValue)
    static var customFont: Int
}

enum keyEnum: String {
    case customFont = "customFont"
}
