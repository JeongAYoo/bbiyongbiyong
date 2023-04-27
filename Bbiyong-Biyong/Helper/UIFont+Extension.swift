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
    
    var customTextFont: UIFont {
        return customFont(ofSize: 17)
    }
    
    var customContentFont: UIFont {
        return customFont(ofSize: 18)
    }
    
    var customTitleFont: UIFont {
        return customFont(ofSize: 20, isBold: true)
    }
    
    var customExtraLargeFont: UIFont {
        return customFont(ofSize: 25, isBold: true)
    }
    
    func customFont(ofSize fontSize: CGFloat, isBold: Bool = false) -> UIFont {
        return .systemFont(ofSize: fontSize)
    }
}
