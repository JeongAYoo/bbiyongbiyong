//
//  UIViewController+Extension.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/05/01.
//

import UIKit

extension UIViewController {
    func setNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .systemBackground
        navigationBarAppearance.shadowColor = nil
        
        let attribute :[NSAttributedString.Key: Any] = [NSAttributedString.Key.font : UIFont().customFont(ofSize: 17, isBold: true)]
        navigationBarAppearance.titleTextAttributes = attribute
        
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance
        navigationController?.setNeedsStatusBarAppearanceUpdate()
    }
}
