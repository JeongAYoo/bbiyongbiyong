//
//  UIFont+Extension.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/04/02.
//

import UIKit

enum CustomFont: Int {
    case system = 0
    case ggocNaeEum = 1
    case muJinJang = 2
    case baegEuiEuiCeonSa = 3
    case seongSirCe = 4
}

extension UIFont {
    /*
     나눔손글씨 꽃내음
     ===> NanumGgocNaeEum
     나눔손글씨 무진장체
     ===> NanumMuJinJangCe
     나눔손글씨 백의의 천사
     ===> NanumBaegEuiEuiCeonSa
     나눔손글씨 성실체
     ===> NanumSeongSirCe
     */
    
    var customSmallTextFont: UIFont {
        return customFont(ofSize: 15)
    }
    
    var customTextFont: UIFont {
        return customFont(ofSize: 17)
    }
    
    var customContentFont: UIFont {
        return customFont(ofSize: 18)
    }
    
    var customTitleFont: UIFont {
        return customFont(ofSize: 20)
    }
    
    var customBoldTitleFont: UIFont {
        return customFont(ofSize: 20, isBold: true)
    }
    
    /// Home - 총금액 표시레이블에 사용
    var customExtraLargeFont: UIFont {
        return customFont(ofSize: 25, isBold: true)
    }
    
    func customFont(ofSize fontSize: CGFloat, isBold: Bool = false) -> UIFont {
        switch UserFont.customFont {
        case CustomFont.system.rawValue:
            return isBold ? .boldSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize)
        case CustomFont.ggocNaeEum.rawValue:
            return UIFont(name: "NanumGgocNaeEum", size: fontSize)!
        case CustomFont.muJinJang.rawValue:
            return UIFont(name: "NanumMuJinJangCe", size: fontSize + 2)!
        case CustomFont.baegEuiEuiCeonSa.rawValue:
            return UIFont(name: "NanumBaegEuiEuiCeonSa", size: fontSize + 3)!
        case CustomFont.seongSirCe.rawValue:
            return UIFont(name: "NanumSeongSirCe", size: fontSize + 2)!
        default:
            return .systemFont(ofSize: fontSize)
        }
    }
}
