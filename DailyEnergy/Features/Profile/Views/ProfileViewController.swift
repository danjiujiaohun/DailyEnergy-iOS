//
//  ProfileViewController.swift
//  DailyEnergy
//
//  Created by AI Assistant on 2024/12/21.
//

import UIKit
import SnapKit

class ProfileViewController: BaseViewController {
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // 用户信息卡片
    private let userInfoCardView = UIView()
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let ageGenderLabel = UILabel()
    private let heightLabel = UILabel()
    
    // 统计卡片
    private let statsCardView = UIView()
    private let checkinStatsView = UIView()
    private let weightLossStatsView = UIView()
    private let usageDaysStatsView = UIView()
    
    // 减重目标卡片
    private let weightGoalCardView = UIView()
    private let goalTitleLabel = UILabel()
    private let currentWeightLabel = UILabel()
    private let targetWeightLabel = UILabel()
    private let progressBarView = UIView()
    private let progressBar = UIView()
    private let goalDescriptionLabel = UILabel()
    
    // 设置菜单
    private let settingsStackView = UIStackView()
    
    // 底部导航栏
    private let bottomTabBar = UIView()
    private let homeTabButton = UIButton()
    private let addTabButton = UIButton()
    private let profileTabButton = UIButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupData()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = UIColor.color(.color_FFFFFF)
        
        // 设置导航栏
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // 添加主要视图
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        setupUserInfoCard()
        setupStatsCard()
        setupWeightGoalCard()
        setupSettingsMenu()
        setupBottomTabBar()
    }
    
    private func setupUserInfoCard() {
        contentView.addSubview(userInfoCardView)
        
        // 设置卡片样式
        userInfoCardView.backgroundColor = UIColor.color(.color_FFFFFF)
        userInfoCardView.layer.cornerRadius = 24
        userInfoCardView.layer.shadowColor = UIColor.black.cgColor
        userInfoCardView.layer.shadowOpacity = 0.1
        userInfoCardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        userInfoCardView.layer.shadowRadius = 8
        
        // 添加渐变背景
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.color(.color_FFFFFF).cgColor, UIColor.color(.color_F0FBF7).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.cornerRadius = 24
        userInfoCardView.layer.insertSublayer(gradientLayer, at: 0)
        
        // 头像
        userInfoCardView.addSubview(avatarImageView)
        avatarImageView.backgroundColor = UIColor.color(.color_5ED4A4)
        avatarImageView.layer.cornerRadius = 30
        avatarImageView.clipsToBounds = true
        
        // 添加头像文字
        let avatarLabel = UILabel()
        avatarImageView.addSubview(avatarLabel)
        avatarLabel.text = "小"
        avatarLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        avatarLabel.textColor = .white
        avatarLabel.textAlignment = .center
        
        avatarLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        // 用户名
        userInfoCardView.addSubview(nameLabel)
        nameLabel.text = "小明"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        nameLabel.textColor = UIColor.color(.color_0A0A0A)
        
        // 年龄性别
        userInfoCardView.addSubview(ageGenderLabel)
        ageGenderLabel.text = "男 · 28岁"
        ageGenderLabel.font = UIFont.systemFont(ofSize: 14)
        ageGenderLabel.textColor = UIColor.color(.color_6A7282)
        
        // 身高
        userInfoCardView.addSubview(heightLabel)
        heightLabel.text = "175cm"
        heightLabel.font = UIFont.systemFont(ofSize: 14)
        heightLabel.textColor = UIColor.color(.color_6A7282)
    }
    
    private func setupStatsCard() {
        contentView.addSubview(statsCardView)
        
        statsCardView.backgroundColor = UIColor.color(.color_FFFFFF)
        statsCardView.layer.cornerRadius = 16
        statsCardView.layer.shadowColor = UIColor.black.cgColor
        statsCardView.layer.shadowOpacity = 0.05
        statsCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        statsCardView.layer.shadowRadius = 4
        
        // 打卡天数统计
        setupStatsItem(
            in: statsCardView,
            view: checkinStatsView,
            iconColor: UIColor.color(.color_5ED4A4),
            value: "7",
            title: "连续打卡",
            unit: "天"
        )
        
        // 减重统计
        setupStatsItem(
            in: statsCardView,
            view: weightLossStatsView,
            iconColor: UIColor.color(.color_FF9F6E),
            value: "2.8",
            title: "已减重量",
            unit: "kg"
        )
        
        // 使用天数统计
        setupStatsItem(
            in: statsCardView,
            view: usageDaysStatsView,
            iconColor: UIColor.color(.color_A8E6CF),
            value: "24",
            title: "使用天数",
            unit: "天"
        )
    }
    
    private func setupStatsItem(in containerView: UIView, view: UIView, iconColor: UIColor, value: String, title: String, unit: String) {
        containerView.addSubview(view)
        
        let iconView = UIView()
        let valueLabel = UILabel()
        let titleLabel = UILabel()
        let unitLabel = UILabel()
        
        view.addSubview(iconView)
        view.addSubview(valueLabel)
        view.addSubview(titleLabel)
        view.addSubview(unitLabel)
        
        iconView.backgroundColor = iconColor
        iconView.layer.cornerRadius = 12
        
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        valueLabel.textColor = UIColor.color(.color_0A0A0A)
        valueLabel.textAlignment = .center
        
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor.color(.color_6A7282)
        titleLabel.textAlignment = .center
        
        unitLabel.text = unit
        unitLabel.font = UIFont.systemFont(ofSize: 12)
        unitLabel.textColor = UIColor.color(.color_99A1AF)
        unitLabel.textAlignment = .center
        
        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        unitLabel.snp.makeConstraints { make in
            make.top.equalTo(valueLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(unitLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func setupWeightGoalCard() {
        contentView.addSubview(weightGoalCardView)
        
        weightGoalCardView.backgroundColor = UIColor.color(.color_FFFFFF)
        weightGoalCardView.layer.cornerRadius = 16
        weightGoalCardView.layer.shadowColor = UIColor.black.cgColor
        weightGoalCardView.layer.shadowOpacity = 0.05
        weightGoalCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        weightGoalCardView.layer.shadowRadius = 4
        
        // 标题
        weightGoalCardView.addSubview(goalTitleLabel)
        goalTitleLabel.text = "减重目标"
        goalTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        goalTitleLabel.textColor = UIColor.color(.color_0A0A0A)
        
        // 当前体重
        weightGoalCardView.addSubview(currentWeightLabel)
        currentWeightLabel.text = "72kg"
        currentWeightLabel.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        currentWeightLabel.textColor = UIColor.color(.color_0A0A0A)
        
        // 目标体重
        weightGoalCardView.addSubview(targetWeightLabel)
        targetWeightLabel.text = "目标体重 65kg"
        targetWeightLabel.font = UIFont.systemFont(ofSize: 14)
        targetWeightLabel.textColor = UIColor.color(.color_6A7282)
        
        // 进度条
        weightGoalCardView.addSubview(progressBarView)
        progressBarView.addSubview(progressBar)
        
        progressBarView.backgroundColor = UIColor.color(.color_F3F4F6)
        progressBarView.layer.cornerRadius = 6
        
        progressBar.backgroundColor = UIColor.color(.color_030213)
        progressBar.layer.cornerRadius = 6
        
        // 目标描述
        weightGoalCardView.addSubview(goalDescriptionLabel)
        goalDescriptionLabel.text = "🎯 坚持下去，还需减重 7kg"
        goalDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        goalDescriptionLabel.textColor = UIColor.color(.color_5ED4A4)
    }
    
    private func setupSettingsMenu() {
        contentView.addSubview(settingsStackView)
        
        settingsStackView.axis = .vertical
        settingsStackView.spacing = 0
        settingsStackView.backgroundColor = UIColor.color(.color_FFFFFF)
        settingsStackView.layer.cornerRadius = 16
        settingsStackView.layer.shadowColor = UIColor.black.cgColor
        settingsStackView.layer.shadowOpacity = 0.05
        settingsStackView.layer.shadowOffset = CGSize(width: 0, height: 2)
        settingsStackView.layer.shadowRadius = 4
        
        // 设置菜单项
        let menuItems = [
            ("基本信息", UIColor.color(.color_5ED4A4)),
            ("目标设置", UIColor.color(.color_FF9F6E)),
            ("通知设置", UIColor.color(.color_A8E6CF)),
            ("隐私设置", UIColor.color(.color_99A1AF)),
            ("帮助与支持", UIColor.color(.color_6A7282))
        ]
        
        for (index, item) in menuItems.enumerated() {
            let menuItemView = createMenuItemView(title: item.0, iconColor: item.1)
            settingsStackView.addArrangedSubview(menuItemView)
            
            // 添加分隔线（除了最后一个）
            if index < menuItems.count - 1 {
                let separatorView = UIView()
                separatorView.backgroundColor = UIColor.color(.color_F3F4F6)
                settingsStackView.addArrangedSubview(separatorView)
                
                separatorView.snp.makeConstraints { make in
                    make.height.equalTo(1)
                }
            }
        }
    }
    
    private func createMenuItemView(title: String, iconColor: UIColor) -> UIView {
        let itemView = UIView()
        
        let iconView = UIView()
        let titleLabel = UILabel()
        let arrowImageView = UIImageView()
        
        itemView.addSubview(iconView)
        itemView.addSubview(titleLabel)
        itemView.addSubview(arrowImageView)
        
        iconView.backgroundColor = iconColor
        iconView.layer.cornerRadius = 12
        
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.color(.color_0A0A0A)
        
        arrowImageView.image = UIImage.image(.arrow_right_icon)
        arrowImageView.tintColor = UIColor.color(.color_99A1AF)
        
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(16)
            make.centerY.equalToSuperview()
            make.right.lessThanOrEqualTo(arrowImageView.snp.left).offset(-16)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }
        
        itemView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        // 添加点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(menuItemTapped(_:)))
        itemView.addGestureRecognizer(tapGesture)
        itemView.tag = title.hashValue
        
        return itemView
    }
    
    private func setupBottomTabBar() {
        view.addSubview(bottomTabBar)
        
        bottomTabBar.backgroundColor = UIColor.color(.color_FFFFFF)
        bottomTabBar.layer.shadowColor = UIColor.black.cgColor
        bottomTabBar.layer.shadowOpacity = 0.1
        bottomTabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        bottomTabBar.layer.shadowRadius = 8
        
        bottomTabBar.addSubview(homeTabButton)
        bottomTabBar.addSubview(addTabButton)
        bottomTabBar.addSubview(profileTabButton)
        
        // 首页按钮
        homeTabButton.setTitle("首页", for: .normal)
        homeTabButton.setTitleColor(UIColor.color(.color_99A1AF), for: .normal)
        homeTabButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        // 添加按钮
        addTabButton.backgroundColor = UIColor.color(.color_5ED4A4)
        addTabButton.layer.cornerRadius = 28
        addTabButton.setTitle("+", for: .normal)
        addTabButton.setTitleColor(.white, for: .normal)
        addTabButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        
        // 个人中心按钮（当前选中）
        profileTabButton.setTitle("我的", for: .normal)
        profileTabButton.setTitleColor(UIColor.color(.color_5ED4A4), for: .normal)
        profileTabButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    private func setupConstraints() {
        // ScrollView约束
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        // 用户信息卡片约束
        userInfoCardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(120)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(16)
            make.top.equalTo(avatarImageView).offset(8)
        }
        
        ageGenderLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
        
        heightLabel.snp.makeConstraints { make in
            make.left.equalTo(ageGenderLabel.snp.right).offset(16)
            make.centerY.equalTo(ageGenderLabel)
        }
        
        // 统计卡片约束
        statsCardView.snp.makeConstraints { make in
            make.top.equalTo(userInfoCardView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(120)
        }
        
        checkinStatsView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3).offset(-13)
        }
        
        weightLossStatsView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3).offset(-13)
        }
        
        usageDaysStatsView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3).offset(-13)
        }
        
        // 减重目标卡片约束
        weightGoalCardView.snp.makeConstraints { make in
            make.top.equalTo(statsCardView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(160)
        }
        
        goalTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        currentWeightLabel.snp.makeConstraints { make in
            make.top.equalTo(goalTitleLabel.snp.bottom).offset(8)
            make.left.equalTo(goalTitleLabel)
        }
        
        targetWeightLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(currentWeightLabel)
        }
        
        progressBarView.snp.makeConstraints { make in
            make.top.equalTo(currentWeightLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(12)
        }
        
        progressBar.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4) // 40%进度
        }
        
        goalDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBarView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        // 设置菜单约束
        settingsStackView.snp.makeConstraints { make in
            make.top.equalTo(weightGoalCardView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        // 底部导航栏约束
        bottomTabBar.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(88)
        }
        
        homeTabButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        
        addTabButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.width.height.equalTo(56)
        }
        
        profileTabButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        
        // 设置contentView的底部约束
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(settingsStackView.snp.bottom).offset(112)
        }
    }
    
    private func setupData() {
        // 这里可以设置初始数据或绑定ViewModel
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 设置用户信息卡片渐变背景
        if let gradientLayer = userInfoCardView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = userInfoCardView.bounds
        }
        
        // 设置整体背景渐变
        let backgroundGradient = CAGradientLayer()
        backgroundGradient.colors = [
            UIColor.color(.color_DCEFEA).cgColor,
            UIColor.color(.color_F5FAF8).cgColor,
            UIColor.color(.color_FFFFFF).cgColor
        ]
        backgroundGradient.locations = [0.0, 0.5, 1.0]
        backgroundGradient.frame = view.bounds
        view.layer.insertSublayer(backgroundGradient, at: 0)
    }
    
    // MARK: - Actions
    @objc private func menuItemTapped(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }
        
        // 添加点击动画
        UIView.animate(withDuration: 0.1, animations: {
            view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                view.transform = CGAffineTransform.identity
            }
        }
        
        // 处理菜单项点击事件
        switch view.tag {
        case "基本信息".hashValue:
            print("点击了基本信息")
        case "目标设置".hashValue:
            print("点击了目标设置")
        case "通知设置".hashValue:
            print("点击了通知设置")
        case "隐私设置".hashValue:
            print("点击了隐私设置")
        case "帮助与支持".hashValue:
            print("点击了帮助与支持")
        default:
            break
        }
    }
}
