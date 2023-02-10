//
//  ViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/11.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var scrollView = UIScrollView()
    var contentView = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    
    }
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.width.centerX.equalTo(scrollView.frameLayoutGuide)
            make.top.bottom.equalTo(scrollView.contentLayoutGuide)
        }
    }

}

