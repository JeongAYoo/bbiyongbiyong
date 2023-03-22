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

enum MainImage {
    private static let imageIds: [String] = [
        "main1_basic",
        "main2_eating1",
        "main3_eating2",
        "main4_eating3",
        "main5_done",
        "main6_over1",
        "main7_over2"
    ]
    
    static subscript(index: Int) -> String {
        let id = imageIds[index]
        return id
    }
}
