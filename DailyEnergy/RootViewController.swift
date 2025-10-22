//
//  RootViewController.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2024/4/23.
//

import UIKit

class RootViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
    }
    
    // MARK: - Setup Methods
    private func setupTabBarController() {
        // 创建各个页面，直接作为TabBar的视图控制器
        // RTRootNavigationController会自动为每个页面提供导航功能
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(
            title: "首页",
            image: UIImage(systemName: "house.fill"),
            tag: 0
        )
        
        let aiViewController = AIViewController()
        aiViewController.tabBarItem = UITabBarItem(
            title: "识图",
            image: UIImage(systemName: "camera.fill"),
            tag: 1
        )
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(
            title: "我的",
            image: UIImage(systemName: "person.fill"),
            tag: 2
        )
        
        // 设置 TabBar 的视图控制器
        viewControllers = [homeViewController, aiViewController, profileViewController]
        
        // 配置 TabBar 样式
        setupTabBarAppearance()
        
        // 设置默认选中的 Tab
        selectedIndex = 0
    }
    
    private func setupTabBarAppearance() {
        // 设置 TabBar 背景色
        tabBar.backgroundColor = UIColor.white
        tabBar.barTintColor = UIColor.white
        
        // 设置选中和未选中的颜色
        tabBar.tintColor = UIColor.color(.color_5ED4A4) // 主题绿色
        tabBar.unselectedItemTintColor = UIColor.color(.color_99A1AF) // 灰色
        
        // 设置 TabBar 的外观
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white
            
            // 设置选中状态
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.color(.color_5ED4A4)
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor.color(.color_5ED4A4)
            ]
            
            // 设置未选中状态
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.color(.color_99A1AF)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor.color(.color_99A1AF)
            ]
            
            tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
        }
        
        // 添加顶部分割线
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.color(.color_F3F4F6).cgColor
    }
}
