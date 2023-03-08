//
//  EmotionImage.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/03/08.
//

import UIKit

enum EmotionImage {
    private static let imageIds: [String] = [
        "anger",
        "shame",
        "depress",
        "sadness",
        "fear",
        "joy",
        "love",
        "pride"
    ]
    
    static subscript(index: Int) -> String {
        let id = imageIds[index]
        return id
    }
}
