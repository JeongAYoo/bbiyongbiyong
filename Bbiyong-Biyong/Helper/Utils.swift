//
//  Utils.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/03/06.
//

import Foundation

class Utils {
    static func getAppVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    static func getBuildVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    }
}
