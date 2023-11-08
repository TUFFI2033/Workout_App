//
//  MainTapBarController.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 01/10/2023.
//

import UIKit

class MainTapBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupItems()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .specialTabBar
        tabBar.tintColor = .specialDarkGreen
        tabBar.unselectedItemTintColor = .specialGray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.specialBrown.cgColor
    }
    
    private func setupItems() {
        let mainVC = MainViewController()
        let statisticVC = StatisticViewController()
        let ProfilVC = ProfilViewController()
        
        setViewControllers([mainVC, statisticVC, ProfilVC], animated: true)
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Main"
        items[1].title = "Statistic"
        items[2].title = "Profile"
        
        items[0].image = UIImage(named: "mainTabBar")
        items[1].image = UIImage(named: "statisticTabBar")
        items[2].image = UIImage(named: "profileTabBar")
        
        UITabBarItem.appearance().setBadgeTextAttributes([.font : UIFont.robotoBold12() as Any], for: .normal)
    }
}
