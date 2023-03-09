//
//  EmotionImage.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/03/08.
//

import UIKit

enum EmotionImage {
    private static let imageIds: [String] = [
        "joy",
        "sadness",
        "love",
        "anger",
        "shame",
        "depress",
        "pride",
        "fear"
    ]
    
    static subscript(index: Int) -> String {
        let id = imageIds[index]
        return id
    }
}
