//
//  MainTabBarController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/15.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
    }
    
    // MARK: - Helpers
    func configureViewControllers() {
        view.backgroundColor = .systemBackground
        
        let home = templateNavigationController(unselectedImage: UIImage(systemName: "house")!,
                                                selectedImage: UIImage(systemName: "house.fill")!,
                                                rootViewController: HomeViewController())
        
        let calendar = templateNavigationController(unselectedImage: UIImage(systemName: "calendar")!,
                                                    selectedImage: UIImage(systemName: "calendar")!,
                                                    rootViewController: CalendarViewController())

        let setting = templateNavigationController(unselectedImage: UIImage(systemName: "gearshape")!,
                                                   selectedImage: UIImage(systemName: "gearshape.fill")!,
                                                   rootViewController: SettingViewController())
        
        viewControllers = [home, calendar, setting]
        home.title = "Home"
        calendar.title = "달력"
        setting.title = "설정"
        tabBar.tintColor = .boldGreen
        tabBar.backgroundColor = .white.withAlphaComponent(0.1)
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .boldGreen
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .clear
        navigationBarAppearance.shadowColor = nil
        nav.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        nav.navigationBar.standardAppearance = navigationBarAppearance
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        
        return nav
    }
}

