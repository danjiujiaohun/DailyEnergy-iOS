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
    private let userInfoStackView = UIStackView()
    private let currentWeightContainerView = UIView()
    private let basalMetabolismContainerView = UIView()
    
    // 统计卡片
    private let statsContainerView = UIView()
    private let checkinStatsView = UIView()
    private let weightLossStatsView = UIView()
    private let usageDaysStatsView = UIView()
    
    // 减重目标卡片
    private let weightGoalCardView = UIView()
    private let goalTitleLabel = UILabel()
    private let goalSubtitleLabel = UILabel()
    private let currentWeightLabel = UILabel()
    private let targetWeightLabel = UILabel()
    private let progressBarContainerView = UIView()
    private let progressBarView = UIView()
    private let goalDescriptionView = UIView()
    
    // 设置菜单
    private let settingsCardView = UIView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupData()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        // RTRootNavigationController会自动管理导航栏，这里设置隐藏
        isNavBarisHidden = true
        
        // 配置ScrollView
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.alwaysBounceVertical = true
        
        // 添加主要视图
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        setupUserInfoCard()
        setupStatsCards()
        setupWeightGoalCard()
        setupSettingsMenu()
    }
    
    private func setupUserInfoCard() {
        contentView.addSubview(userInfoCardView)
        
        // 设置卡片样式 - 346x261px
        userInfoCardView.backgroundColor = UIColor.color(.color_FFFFFF)
        userInfoCardView.layer.cornerRadius = 24.fit()
        userInfoCardView.layer.borderWidth = 1.fit()
        userInfoCardView.layer.borderColor = UIColor.color(.color_A8E6CF).withAlphaComponent(0.3).cgColor
        
        // 阴影效果
        userInfoCardView.layer.shadowColor = UIColor.black.cgColor
        userInfoCardView.layer.shadowOpacity = 0.1
        userInfoCardView.layer.shadowOffset = CGSize(width: 0, height: 10.fit())
        userInfoCardView.layer.shadowRadius = 15.fit()
        userInfoCardView.layer.masksToBounds = false
        
        // 头像 - 80x73px，圆形
        userInfoCardView.addSubview(avatarImageView)
        avatarImageView.layer.cornerRadius = 40.fit()
        avatarImageView.layer.borderWidth = 3.fit()
        avatarImageView.layer.borderColor = UIColor.color(.color_A8E6CF).withAlphaComponent(0.3).cgColor
        avatarImageView.clipsToBounds = true
        
        // 添加头像文字
        let avatarLabel = UILabel()
        avatarImageView.addSubview(avatarLabel)
        avatarLabel.text = "小"
        avatarLabel.font = UIFont.systemFont(ofSize: 24.fit(), weight: .medium)
        avatarLabel.textColor = .white
        avatarLabel.textAlignment = .center
        
        avatarLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        // 用户信息区域
        let userInfoContainer = UIView()
        userInfoCardView.addSubview(userInfoContainer)
        
        // 用户名
        userInfoContainer.addSubview(nameLabel)
        nameLabel.text = "小明"
        nameLabel.font = UIFont.systemFont(ofSize: 20.fit(), weight: .medium)
        nameLabel.textColor = UIColor.color(.color_0A0A0A)
        
        // 用户详细信息
        userInfoStackView.axis = .horizontal
        userInfoStackView.spacing = 0
        userInfoStackView.alignment = .center
        userInfoContainer.addSubview(userInfoStackView)
        
        let genderLabel = createInfoLabel(text: "男", color: UIColor.color(.color_6A7282))
        let dot1 = createInfoLabel(text: "·", color: UIColor.color(.color_6A7282))
        let ageLabel = createInfoLabel(text: "28岁", color: UIColor.color(.color_6A7282))
        let dot2 = createInfoLabel(text: "·", color: UIColor.color(.color_6A7282))
        let heightLabel = createInfoLabel(text: "175cm", color: UIColor.color(.color_6A7282))
        
        [genderLabel, dot1, ageLabel, dot2, heightLabel].forEach { label in
            userInfoStackView.addArrangedSubview(label)
        }
        
        // 当前体重和基础代谢容器
        let dataContainerView = UIView()
        userInfoCardView.addSubview(dataContainerView)
        
        // 当前体重
        dataContainerView.addSubview(currentWeightContainerView)
        setupDataContainer(
            container: currentWeightContainerView,
            title: "当前体重",
            value: "72",
            unit: "kg",
            valueColor: UIColor.color(.color_5ED4A4)
        )
        
        // 基础代谢
        dataContainerView.addSubview(basalMetabolismContainerView)
        setupDataContainer(
            container: basalMetabolismContainerView,
            title: "基础代谢",
            value: "1720",
            unit: "kcal",
            valueColor: UIColor.color(.color_FF9F6E)
        )
        
        // 约束设置
        avatarImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(23.fit())
            make.top.equalToSuperview().offset(23.fit())
            make.width.height.equalTo(80.fit())
        }
        
        userInfoContainer.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(16.fit())
            make.top.equalTo(avatarImageView)
            make.right.equalToSuperview().offset(-23.fit())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        userInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4.fit())
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        dataContainerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(23.fit())
            make.right.equalToSuperview().offset(-23.fit())
            make.bottom.equalToSuperview().offset(-23.fit())
            make.height.equalTo(84.fit())
        }
        
        currentWeightContainerView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.48)
        }
        
        basalMetabolismContainerView.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.48)
        }
    }
    
    private func setupStatsCards() {
        contentView.addSubview(statsContainerView)
        
        // 连续打卡卡片
        statsContainerView.addSubview(checkinStatsView)
        setupStatsCard(
            cardView: checkinStatsView,
            value: "7",
            title: "连续打卡",
            iconName: .checkin_icon,
            backgroundColor: UIColor.color(.color_F0FBF7),
            borderColor: UIColor.color(.color_A8E6CF).withAlphaComponent(0.2)
        )
        
        // 已减重卡片
        statsContainerView.addSubview(weightLossStatsView)
        setupStatsCard(
            cardView: weightLossStatsView,
            value: "2.8",
            title: "已减重kg",
            iconName: .weight_loss_icon,
            backgroundColor: UIColor.color(.color_FFF5F0),
            borderColor: UIColor.color(.color_FF9F6E).withAlphaComponent(0.2)
        )
        
        // 使用天数卡片
        statsContainerView.addSubview(usageDaysStatsView)
        setupStatsCard(
            cardView: usageDaysStatsView,
            value: "24",
            title: "使用天数",
            iconName: .usage_days_icon,
            backgroundColor: UIColor.color(.color_F5F3FF),
            borderColor: UIColor.color(.color_E9D4FF).withAlphaComponent(0.2)
        )
        
        // 约束设置
        checkinStatsView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(107.fit())
        }
        
        weightLossStatsView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(107.fit())
        }
        
        usageDaysStatsView.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(107.fit())
        }
    }
    
    private func setupWeightGoalCard() {
        contentView.addSubview(weightGoalCardView)
        
        // 设置卡片样式 - 346x225px，匹配Figma设计
        weightGoalCardView.backgroundColor = UIColor.color(.color_FFFFFF)
        weightGoalCardView.layer.cornerRadius = 24.fit()
        weightGoalCardView.layer.borderWidth = 1.fit()
        weightGoalCardView.layer.borderColor = UIColor.color(.color_F3F4F6).cgColor
        
        // 阴影效果
        weightGoalCardView.layer.shadowColor = UIColor.black.cgColor
        weightGoalCardView.layer.shadowOpacity = 0.1
        weightGoalCardView.layer.shadowOffset = CGSize(width: 0, height: 1.fit())
        weightGoalCardView.layer.shadowRadius = 3.fit()
        weightGoalCardView.layer.masksToBounds = false
        
        // 标题区域
        let titleContainer = UIView()
        weightGoalCardView.addSubview(titleContainer)
        
        titleContainer.addSubview(goalTitleLabel)
        goalTitleLabel.text = "减重目标"
        goalTitleLabel.font = UIFont.systemFont(ofSize: 18.fit(), weight: .medium)
        goalTitleLabel.textColor = UIColor.color(.color_0A0A0A)
        
        titleContainer.addSubview(goalSubtitleLabel)
        goalSubtitleLabel.text = "还需减 7kg"
        goalSubtitleLabel.font = UIFont.systemFont(ofSize: 14.fit())
        goalSubtitleLabel.textColor = UIColor.color(.color_6A7282)
        
        // 进度区域
        let progressContainer = UIView()
        weightGoalCardView.addSubview(progressContainer)
        
        // 当前体重标签
        let currentWeightContainer = UIView()
        progressContainer.addSubview(currentWeightContainer)
        
        let currentWeightTitleLabel = UILabel()
        currentWeightTitleLabel.text = "当前体重"
        currentWeightTitleLabel.font = UIFont.systemFont(ofSize: 12.fit())
        currentWeightTitleLabel.textColor = UIColor.color(.color_6A7282)
        currentWeightContainer.addSubview(currentWeightTitleLabel)
        
        currentWeightLabel.text = "72kg"
        currentWeightLabel.font = UIFont.systemFont(ofSize: 20.fit(), weight: .medium)
        currentWeightLabel.textColor = UIColor.color(.color_0A0A0A)
        currentWeightContainer.addSubview(currentWeightLabel)
        
        // 进度条
        progressContainer.addSubview(progressBarContainerView)
        progressBarContainerView.backgroundColor = UIColor.color(.color_F3F4F6)
        progressBarContainerView.layer.cornerRadius = 4.fit()
        
        progressBarContainerView.addSubview(progressBarView)
        progressBarView.backgroundColor = UIColor.color(.color_030213)
        progressBarView.layer.cornerRadius = 4.fit()
        
        // 目标体重标签
        let targetWeightContainer = UIView()
        progressContainer.addSubview(targetWeightContainer)
        
        let targetWeightTitleLabel = UILabel()
        targetWeightTitleLabel.text = "目标体重"
        targetWeightTitleLabel.font = UIFont.systemFont(ofSize: 12.fit())
        targetWeightTitleLabel.textColor = UIColor.color(.color_6A7282)
        targetWeightContainer.addSubview(targetWeightTitleLabel)
        
        targetWeightLabel.text = "65kg"
        targetWeightLabel.font = UIFont.systemFont(ofSize: 20.fit(), weight: .medium)
        targetWeightLabel.textColor = UIColor.color(.color_5ED4A4)
        targetWeightContainer.addSubview(targetWeightLabel)
        
        // 目标描述
        weightGoalCardView.addSubview(goalDescriptionView)
        goalDescriptionView.backgroundColor = UIColor.color(.color_DCEFEA)
        goalDescriptionView.layer.cornerRadius = 16.fit()
        
        let goalDescriptionLabel = UILabel()
        goalDescriptionLabel.text = "🎯 预计 12周 达成目标"
        goalDescriptionLabel.font = UIFont.systemFont(ofSize: 14.fit())
        goalDescriptionLabel.textColor = UIColor.color(.color_4A5565)
        goalDescriptionLabel.textAlignment = .center
        goalDescriptionView.addSubview(goalDescriptionLabel)
        
        // 约束设置
        titleContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23.fit())
            make.left.equalToSuperview().offset(23.fit())
            make.right.equalToSuperview().offset(-23.fit())
            make.height.equalTo(28.fit())
        }
        
        goalTitleLabel.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
        }
        
        goalSubtitleLabel.snp.makeConstraints { make in
            make.right.centerY.equalToSuperview()
        }
        
        progressContainer.snp.makeConstraints { make in
            make.top.equalTo(titleContainer.snp.bottom).offset(40.fit())
            make.left.equalToSuperview().offset(23.fit())
            make.right.equalToSuperview().offset(-23.fit())
            make.height.equalTo(45.fit())
        }
        
        currentWeightContainer.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(59.fit())
        }
        
        currentWeightTitleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        currentWeightLabel.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
        }
        
        progressBarContainerView.snp.makeConstraints { make in
            make.left.equalTo(currentWeightContainer.snp.right).offset(16.fit())
            make.right.equalTo(targetWeightContainer.snp.left).offset(-16.fit())
            make.centerY.equalToSuperview()
            make.height.equalTo(8.fit())
        }
        
        progressBarView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3) // 30%进度
        }
        
        targetWeightContainer.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(49.fit())
        }
        
        targetWeightTitleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        targetWeightLabel.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
        }
        
        goalDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(progressContainer.snp.bottom).offset(12.fit())
            make.left.equalToSuperview().offset(23.fit())
            make.right.equalToSuperview().offset(-23.fit())
            make.bottom.equalToSuperview().offset(-23.fit())
            make.height.equalTo(52.fit())
        }
        
        goalDescriptionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupSettingsMenu() {
        contentView.addSubview(settingsCardView)
        
        // 设置卡片样式
        settingsCardView.backgroundColor = UIColor.color(.color_FFFFFF)
        settingsCardView.layer.cornerRadius = 16.fit()
        settingsCardView.layer.borderWidth = 1.fit()
        settingsCardView.layer.borderColor = UIColor.color(.color_F3F4F6).cgColor
        
        // 阴影效果
        settingsCardView.layer.shadowColor = UIColor.black.cgColor
        settingsCardView.layer.shadowOpacity = 0.1
        settingsCardView.layer.shadowOffset = CGSize(width: 0, height: 1.fit())
        settingsCardView.layer.shadowRadius = 3.fit()
        settingsCardView.layer.masksToBounds = false
        
        // 设置菜单项
        let menuItems = [
            ("基本信息", iconName.basic_info_icon, UIColor.color(.color_5ED4A4)),
            ("目标设置", iconName.goal_setting_icon, UIColor.color(.color_FF9F6E)),
            ("通知设置", iconName.notification_icon, UIColor.color(.color_5ED4A4)),
            ("隐私与安全", iconName.privacy_icon, UIColor.color(.color_FF9F6E)),
            ("帮助与反馈", iconName.help_icon, UIColor.color(.color_5ED4A4))
        ]
        
        var previousView: UIView? = nil
        
        for (index, item) in menuItems.enumerated() {
            let menuItemView = createMenuItemView(title: item.0, iconName: item.1, iconColor: item.2)
            settingsCardView.addSubview(menuItemView)
            
            menuItemView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.height.equalTo(70.fit())
                
                if let previous = previousView {
                    make.top.equalTo(previous.snp.bottom)
                } else {
                    make.top.equalToSuperview()
                }
            }
            
            // 添加分隔线（除了最后一个）
            if index < menuItems.count - 1 {
                let separatorView = UIView()
                separatorView.backgroundColor = UIColor.color(.color_F3F4F6)
                settingsCardView.addSubview(separatorView)
                
                separatorView.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(16.fit())
                    make.right.equalToSuperview().offset(-16.fit())
                    make.top.equalTo(menuItemView.snp.bottom)
                    make.height.equalTo(1.fit())
                }
                
                previousView = separatorView
            } else {
                previousView = menuItemView
            }
        }
    }
    
    // MARK: - Helper Methods
    private func createInfoLabel(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14.fit())
        label.textColor = color
        return label
    }
    
    private func setupDataContainer(container: UIView, title: String, value: String, unit: String, valueColor: UIColor) {
        container.backgroundColor = UIColor.color(.color_FFFFFF).withAlphaComponent(0.6)
        container.layer.cornerRadius = 16.fit()
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12.fit())
        titleLabel.textColor = UIColor.color(.color_6A7282)
        container.addSubview(titleLabel)
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 24.fit(), weight: .medium)
        valueLabel.textColor = valueColor
        container.addSubview(valueLabel)
        
        let unitLabel = UILabel()
        unitLabel.text = unit
        unitLabel.font = UIFont.systemFont(ofSize: 14.fit())
        unitLabel.textColor = UIColor.color(.color_99A1AF)
        container.addSubview(unitLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16.fit())
            make.centerX.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4.fit())
            make.centerX.equalToSuperview()
        }
        
        unitLabel.snp.makeConstraints { make in
            make.left.equalTo(valueLabel.snp.right).offset(4.fit())
            make.centerY.equalTo(valueLabel)
        }
    }
    
    private func setupStatsCard(cardView: UIView, value: String, title: String, iconName: iconName, backgroundColor: UIColor, borderColor: UIColor) {
        // 设置卡片样式 - 107x143px
        cardView.backgroundColor = backgroundColor
        cardView.layer.cornerRadius = 16.fit()
        cardView.layer.borderWidth = 1.fit()
        cardView.layer.borderColor = borderColor.cgColor
        
        // 数值标签
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 24.fit(), weight: .medium)
        valueLabel.textColor = UIColor.color(.color_0A0A0A)
        valueLabel.textAlignment = .center
        cardView.addSubview(valueLabel)
        
        // 图标
        let iconImageView = UIImageView()
        iconImageView.image = UIImage.image(iconName)
        iconImageView.contentMode = .scaleAspectFit
        cardView.addSubview(iconImageView)
        
        // 标题标签
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12.fit())
        titleLabel.textColor = UIColor.color(.color_6A7282)
        titleLabel.textAlignment = .center
        cardView.addSubview(titleLabel)
        
        // 约束设置
        valueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11.fit())
            make.centerX.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(valueLabel.snp.bottom).offset(26.fit())
            make.centerX.equalToSuperview()
            make.width.height.equalTo(18.fit())
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(8.fit())
            make.centerX.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-11.fit())
        }
    }
    
    private func createMenuItemView(title: String, iconName: iconName, iconColor: UIColor) -> UIView {
        let itemView = UIView()
        
        // 图标容器
        let iconContainer = UIView()
        iconContainer.backgroundColor = iconColor
        iconContainer.layer.cornerRadius = 20.fit()
        itemView.addSubview(iconContainer)
        
        // 图标
        let iconImageView = UIImageView()
        iconImageView.image = UIImage.image(iconName)
        iconImageView.tintColor = UIColor.white
        iconImageView.contentMode = .scaleAspectFit
        iconContainer.addSubview(iconImageView)
        
        // 标题
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14.fit())
        titleLabel.textColor = UIColor.color(.color_0A0A0A)
        itemView.addSubview(titleLabel)
        
        // 箭头
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage.image(.arrow_right_icon)
        arrowImageView.tintColor = UIColor.color(.color_6A7282)
        arrowImageView.contentMode = .scaleAspectFit
        itemView.addSubview(arrowImageView)
        
        // 添加点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(menuItemTapped(_:)))
        itemView.addGestureRecognizer(tapGesture)
        itemView.tag = title.hashValue
        
        // 约束设置
        iconContainer.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.fit())
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40.fit())
        }
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(20.fit())
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconContainer.snp.right).offset(12.fit())
            make.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.fit())
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20.fit())
        }
        
        return itemView
    }
    
    private func setupConstraints() {
        // ScrollView约束 - 修复滚动问题
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        // ContentView约束 - 修复内容大小计算
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        // 用户信息卡片约束 - 346x261px
        userInfoCardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16.fit())
            make.left.equalToSuperview().offset(24.fit())
            make.right.equalToSuperview().offset(-24.fit())
            make.height.equalTo(261.fit())
        }
        
        // 统计卡片约束 - 346x143px
        statsContainerView.snp.makeConstraints { make in
            make.top.equalTo(userInfoCardView.snp.bottom).offset(24.fit())
            make.left.equalToSuperview().offset(24.fit())
            make.right.equalToSuperview().offset(-24.fit())
            make.height.equalTo(143.fit())
        }
        
        // 减重目标卡片约束 - 346x225px
        weightGoalCardView.snp.makeConstraints { make in
            make.top.equalTo(statsContainerView.snp.bottom).offset(24.fit())
            make.left.equalToSuperview().offset(24.fit())
            make.right.equalToSuperview().offset(-24.fit())
            make.height.equalTo(225.fit())
        }
        
        // 设置菜单约束
        settingsCardView.snp.makeConstraints { make in
            make.top.equalTo(weightGoalCardView.snp.bottom).offset(24.fit())
            make.left.equalToSuperview().offset(24.fit())
            make.right.equalToSuperview().offset(-24.fit())
            make.height.equalTo(350.fit()) // 5个菜单项 * 70px
        }
        
        // 设置contentView的底部约束 - 确保滚动内容高度正确
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(settingsCardView.snp.bottom).offset(100.fit()) // 底部留出足够空间
        }
    }
    
    private func setupData() {
        // 这里可以设置初始数据或绑定ViewModel
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 设置整体背景渐变
        setupBackgroundGradient()
        
        // 设置用户信息卡片渐变背景
        setupUserInfoCardGradient()
        
        // 设置统计卡片渐变背景
        setupStatsCardsGradient()
        
        // 设置目标描述渐变背景
        setupGoalDescriptionGradient()
    }
    
    private func setupBackgroundGradient() {
        // 移除旧的渐变层
        view.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        
        // 匹配Figma设计的背景渐变
        let backgroundGradient = CAGradientLayer()
        backgroundGradient.colors = [
            UIColor.color(.color_DCEFEA).cgColor,  // #dcefea
            UIColor.color(.color_F5FAF8).cgColor,  // #f5faf8
            UIColor.color(.color_FFFFFF).cgColor   // #ffffff
        ]
        backgroundGradient.locations = [0.0, 0.5, 1.0]
        backgroundGradient.frame = view.bounds
        view.layer.insertSublayer(backgroundGradient, at: 0)
    }
    
    private func setupUserInfoCardGradient() {
        // 移除旧的渐变层
        userInfoCardView.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        
        // 匹配Figma设计的用户信息卡片渐变
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.color(.color_FFFFFF).cgColor,  // #ffffff
            UIColor.color(.color_F0FBF7).cgColor   // #f0fbf7
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = userInfoCardView.bounds
        gradientLayer.cornerRadius = 24
        userInfoCardView.layer.insertSublayer(gradientLayer, at: 0)
        
        // 设置头像渐变背景
        avatarImageView.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        
        let avatarGradient = CAGradientLayer()
        avatarGradient.colors = [
            UIColor.color(.color_A8E6CF).cgColor,  // #a8e6cf
            UIColor.color(.color_5ED4A4).cgColor   // #5ed4a4
        ]
        avatarGradient.locations = [0.0, 1.0]
        avatarGradient.frame = avatarImageView.bounds
        avatarGradient.cornerRadius = 40
        avatarImageView.layer.insertSublayer(avatarGradient, at: 0)
    }
    
    private func setupStatsCardsGradient() {
        // 连续打卡卡片渐变 - 匹配Figma设计
        setupCardGradient(
            cardView: checkinStatsView,
            colors: [UIColor.color(.color_F0FBF7).cgColor, UIColor.color(.color_FFFFFF).cgColor]
        )
        
        // 已减重卡片渐变 - 匹配Figma设计
        setupCardGradient(
            cardView: weightLossStatsView,
            colors: [UIColor.color(.color_FFF5F0).cgColor, UIColor.color(.color_FFFFFF).cgColor]
        )
        
        // 使用天数卡片渐变 - 匹配Figma设计
        setupCardGradient(
            cardView: usageDaysStatsView,
            colors: [UIColor.color(.color_F5F3FF).cgColor, UIColor.color(.color_FFFFFF).cgColor]
        )
    }
    
    private func setupCardGradient(cardView: UIView, colors: [CGColor]) {
        // 移除旧的渐变层
        cardView.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = cardView.bounds
        gradientLayer.cornerRadius = 16
        cardView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupGoalDescriptionGradient() {
        // 移除旧的渐变层
        goalDescriptionView.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        
        // 匹配Figma设计的目标描述渐变
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.color(.color_DCEFEA).cgColor,  // #dcefea
            UIColor.color(.color_F0FBF7).cgColor   // #f0fbf7
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = goalDescriptionView.bounds
        gradientLayer.cornerRadius = 16
        goalDescriptionView.layer.insertSublayer(gradientLayer, at: 0)
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
        case "隐私与安全".hashValue:
            print("点击了隐私与安全")
        case "帮助与反馈".hashValue:
            print("点击了帮助与反馈")
        default:
            break
        }
    }
}
