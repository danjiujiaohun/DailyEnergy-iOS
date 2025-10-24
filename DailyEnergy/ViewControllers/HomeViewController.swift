//
//  HomeViewController.swift
//  DailyEnergy
//
//  Created by AI Assistant on 2024/12/21.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController {
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // 问候语部分
    private let greetingLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    // 热量卡片
    private let calorieCardView = UIView()
    private let remainingCalorieLabel = UILabel()
    private let calorieValueLabel = UILabel()
    private let calorieUnitLabel = UILabel()
    private let progressView = UIView()
    private let progressBar = UIView()
    private let intakeIndicatorView = UIView()
    private let burnIndicatorView = UIView()
    private let intakeLabel = UILabel()
    private let burnLabel = UILabel()
    
    // 热量统计卡片
    private let intakeStatsView = UIView()
    private let burnStatsView = UIView()
    private let targetStatsView = UIView()
    
    // 记录体重按钮
    private let recordWeightButton = UIButton()
    
    // 今日食物摄入部分
    private let foodSectionView = UIView()
    private let foodTitleLabel = UILabel()
    private let foodCalorieLabel = UILabel()
    private let foodListStackView = UIStackView()
    private let addFoodButton = UIButton()
    
    // 今日运动消耗部分
    private let exerciseSectionView = UIView()
    private let exerciseTitleLabel = UILabel()
    private let exerciseCalorieLabel = UILabel()
    private let exerciseListStackView = UIStackView()
    private let addExerciseButton = UIButton()
    
    // 热量趋势图表部分
    private let chartSectionView = UIView()
    private let chartTitleLabel = UILabel()
    private let chartPeriodStackView = UIStackView()
    private let chartView = UIView()
    private let chartDescriptionLabel = UILabel()
    

    
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
        
        // RTRootNavigationController会自动管理导航栏，这里设置隐藏
        isNavBarisHidden = true
        
        // 添加主要视图
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        setupGreetingSection()
        setupCalorieCard()
        setupFoodSection()
        setupExerciseSection()
        setupChartSection()
    }
    
    private func setupGreetingSection() {
        contentView.addSubview(greetingLabel)
        contentView.addSubview(subtitleLabel)
        
        greetingLabel.text = "早上好！"
        greetingLabel.font = UIFont.systemFont(ofSize: 24.fit(), weight: .medium)
        greetingLabel.textColor = UIColor.color(.color_0A0A0A)
        
        subtitleLabel.text = "让我们保持健康的一天"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16.fit())
        subtitleLabel.textColor = UIColor.color(.color_6A7282)
    }
    
    private func setupCalorieCard() {
        contentView.addSubview(calorieCardView)
        
        // 设置卡片样式
        calorieCardView.backgroundColor = UIColor.color(.color_FFFFFF)
        calorieCardView.layer.cornerRadius = 24.fit()
        calorieCardView.layer.shadowColor = UIColor.black.cgColor
        calorieCardView.layer.shadowOpacity = 0.1
        calorieCardView.layer.shadowOffset = CGSize(width: 0, height: 4.fit())
        calorieCardView.layer.shadowRadius = 8.fit()
        
        // 添加渐变背景
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.color(.color_FFFFFF).cgColor, UIColor.color(.color_F0FBF7).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.cornerRadius = 24.fit()
        calorieCardView.layer.insertSublayer(gradientLayer, at: 0)
        
        // 记录体重按钮
        calorieCardView.addSubview(recordWeightButton)
        recordWeightButton.backgroundColor = UIColor.color(.color_5ED4A4)
        recordWeightButton.layer.cornerRadius = 14.fit()
        recordWeightButton.setTitle("记录体重", for: .normal)
        recordWeightButton.setTitleColor(.white, for: .normal)
        recordWeightButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.fit())
        
        // 剩余热量标题
        calorieCardView.addSubview(remainingCalorieLabel)
        remainingCalorieLabel.text = "今日剩余热量"
        remainingCalorieLabel.font = UIFont.systemFont(ofSize: 16.fit())
        remainingCalorieLabel.textColor = UIColor.color(.color_6A7282)
        remainingCalorieLabel.textAlignment = .center
        
        // 热量数值
        calorieCardView.addSubview(calorieValueLabel)
        calorieCardView.addSubview(calorieUnitLabel)
        
        calorieValueLabel.text = "1300"
        calorieValueLabel.font = UIFont.systemFont(ofSize: 48.fit(), weight: .regular)
        calorieValueLabel.textColor = UIColor.color(.color_0A0A0A)
        
        calorieUnitLabel.text = "kcal"
        calorieUnitLabel.font = UIFont.systemFont(ofSize: 16.fit())
        calorieUnitLabel.textColor = UIColor.color(.color_99A1AF)
        
        // 进度条
        calorieCardView.addSubview(progressView)
        progressView.addSubview(progressBar)
        
        progressView.backgroundColor = UIColor.color(.color_F3F4F6)
        progressView.layer.cornerRadius = 6.fit()
        
        progressBar.backgroundColor = UIColor.color(.color_030213)
        progressBar.layer.cornerRadius = 6.fit()
        
        // 指示器
        calorieCardView.addSubview(intakeIndicatorView)
        calorieCardView.addSubview(burnIndicatorView)
        calorieCardView.addSubview(intakeLabel)
        calorieCardView.addSubview(burnLabel)
        
        intakeIndicatorView.backgroundColor = UIColor.color(.color_FF9F6E)
        intakeIndicatorView.layer.cornerRadius = 6.fit()
        
        burnIndicatorView.backgroundColor = UIColor.color(.color_5ED4A4)
        burnIndicatorView.layer.cornerRadius = 6.fit()
        
        intakeLabel.text = "摄入 850"
        intakeLabel.font = UIFont.systemFont(ofSize: 14.fit())
        intakeLabel.textColor = UIColor.color(.color_4A5565)
        
        burnLabel.text = "消耗 430"
        burnLabel.font = UIFont.systemFont(ofSize: 14.fit())
        burnLabel.textColor = UIColor.color(.color_4A5565)
        
        // 统计卡片
        setupStatsCards()
    }
    
    private func setupStatsCards() {
        calorieCardView.addSubview(intakeStatsView)
        calorieCardView.addSubview(burnStatsView)
        calorieCardView.addSubview(targetStatsView)
        
        // 摄入统计卡片
        intakeStatsView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        intakeStatsView.layer.cornerRadius = 16.fit()
        
        let intakeIconView = UIView()
        let intakeValueLabel = UILabel()
        let intakeTitleLabel = UILabel()
        
        intakeStatsView.addSubview(intakeIconView)
        intakeStatsView.addSubview(intakeValueLabel)
        intakeStatsView.addSubview(intakeTitleLabel)
        
        intakeIconView.backgroundColor = UIColor.color(.color_FF9F6E)
        intakeIconView.layer.cornerRadius = 10.fit()
        
        intakeValueLabel.text = "850"
        intakeValueLabel.font = UIFont.systemFont(ofSize: 14.fit(), weight: .medium)
        intakeValueLabel.textColor = UIColor.color(.color_0A0A0A)
        intakeValueLabel.textAlignment = .center
        
        intakeTitleLabel.text = "摄入"
        intakeTitleLabel.font = UIFont.systemFont(ofSize: 12.fit())
        intakeTitleLabel.textColor = UIColor.color(.color_6A7282)
        intakeTitleLabel.textAlignment = .center
        
        intakeIconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.fit())
            make.centerX.equalToSuperview()
            make.width.height.equalTo(20.fit())
        }
        
        intakeTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12.fit())
            make.centerX.equalToSuperview()
        }
        
        intakeValueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(intakeIconView.snp.bottom).offset(4.fit())
            make.bottom.equalTo(intakeTitleLabel.snp.top).offset(-4.fit())
        }
        
        // 消耗统计卡片
        burnStatsView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        burnStatsView.layer.cornerRadius = 16.fit()
        
        let burnIconView = UIView()
        let burnValueLabel = UILabel()
        let burnTitleLabel = UILabel()
        
        burnStatsView.addSubview(burnIconView)
        burnStatsView.addSubview(burnValueLabel)
        burnStatsView.addSubview(burnTitleLabel)
        
        burnIconView.backgroundColor = UIColor.color(.color_5ED4A4)
        burnIconView.layer.cornerRadius = 10.fit()
        
        burnValueLabel.text = "430"
        burnValueLabel.font = UIFont.systemFont(ofSize: 14.fit(), weight: .medium)
        burnValueLabel.textColor = UIColor.color(.color_0A0A0A)
        burnValueLabel.textAlignment = .center
        
        burnTitleLabel.text = "消耗"
        burnTitleLabel.font = UIFont.systemFont(ofSize: 12.fit())
        burnTitleLabel.textColor = UIColor.color(.color_6A7282)
        burnTitleLabel.textAlignment = .center
        
        burnIconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.fit())
            make.centerX.equalToSuperview()
            make.width.height.equalTo(20.fit())
        }
        
        burnTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12.fit())
            make.centerX.equalToSuperview()
        }
        
        burnValueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(burnIconView.snp.bottom).offset(4.fit())
            make.bottom.equalTo(burnTitleLabel.snp.top).offset(-4.fit())
        }
        
        // 目标统计卡片
        targetStatsView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        targetStatsView.layer.cornerRadius = 16.fit()
        
        let targetIconView = UIView()
        let targetValueLabel = UILabel()
        let targetTitleLabel = UILabel()
        
        targetStatsView.addSubview(targetIconView)
        targetStatsView.addSubview(targetValueLabel)
        targetStatsView.addSubview(targetTitleLabel)
        
        targetIconView.backgroundColor = UIColor.color(.color_A8E6CF)
        targetIconView.layer.cornerRadius = 10.fit()
        
        targetValueLabel.text = "1720"
        targetValueLabel.font = UIFont.systemFont(ofSize: 14.fit(), weight: .medium)
        targetValueLabel.textColor = UIColor.color(.color_0A0A0A)
        targetValueLabel.textAlignment = .center
        
        targetTitleLabel.text = "目标"
        targetTitleLabel.font = UIFont.systemFont(ofSize: 12.fit())
        targetTitleLabel.textColor = UIColor.color(.color_6A7282)
        targetTitleLabel.textAlignment = .center
        
        targetIconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.fit())
            make.centerX.equalToSuperview()
            make.width.height.equalTo(20.fit())
        }
        
        targetTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12.fit())
            make.centerX.equalToSuperview()
        }
        
        targetValueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(targetIconView.snp.bottom).offset(4.fit())
            make.bottom.equalTo(targetTitleLabel.snp.top).offset(-4.fit())
        }
    }
    
    private func setupFoodSection() {
        contentView.addSubview(foodSectionView)
        
        // 标题部分
        foodSectionView.addSubview(foodTitleLabel)
        foodSectionView.addSubview(foodCalorieLabel)
        
        foodTitleLabel.text = "今日食物摄入"
        foodTitleLabel.font = UIFont.systemFont(ofSize: 18.fit(), weight: .medium)
        foodTitleLabel.textColor = UIColor.color(.color_0A0A0A)
        
        foodCalorieLabel.text = "850 kcal"
        foodCalorieLabel.font = UIFont.systemFont(ofSize: 14.fit())
        foodCalorieLabel.textColor = UIColor.color(.color_FF9F6E)
        
        // 食物列表
        foodSectionView.addSubview(foodListStackView)
        foodListStackView.axis = .vertical
        foodListStackView.spacing = 8.fit()
        
        // 添加示例食物项
        addFoodItem(emoji: "🍞", title: "早餐 - 全麦面包", time: "08:30", calories: "320")
        addFoodItem(emoji: "🥗", title: "午餐 - 鸡胸沙拉", time: "12:45", calories: "450")
        addFoodItem(emoji: "🍎", title: "下午茶 - 苹果", time: "15:20", calories: "80")
        
        // 添加食物按钮
        foodSectionView.addSubview(addFoodButton)
        addFoodButton.backgroundColor = UIColor.color(.color_FF9F6E).withAlphaComponent(0.1)
        addFoodButton.layer.cornerRadius = 16.fit()
        addFoodButton.setTitle("+ 记录摄入食物", for: .normal)
        addFoodButton.setTitleColor(UIColor.color(.color_FF9F6E), for: .normal)
        addFoodButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.fit(), weight: .medium)
    }
    
    private func setupExerciseSection() {
        contentView.addSubview(exerciseSectionView)
        
        // 标题部分
        exerciseSectionView.addSubview(exerciseTitleLabel)
        exerciseSectionView.addSubview(exerciseCalorieLabel)
        
        exerciseTitleLabel.text = "今日运动消耗"
        exerciseTitleLabel.font = UIFont.systemFont(ofSize: 18.fit(), weight: .medium)
        exerciseTitleLabel.textColor = UIColor.color(.color_0A0A0A)
        
        exerciseCalorieLabel.text = "430 kcal"
        exerciseCalorieLabel.font = UIFont.systemFont(ofSize: 14.fit())
        exerciseCalorieLabel.textColor = UIColor.color(.color_5ED4A4)
        
        // 运动列表
        exerciseSectionView.addSubview(exerciseListStackView)
        exerciseListStackView.axis = .vertical
        exerciseListStackView.spacing = 8.fit()
        
        // 添加示例运动项
        addExerciseItem(emoji: "🏃", title: "晨跑", time: "07:00 · 30分钟", calories: "+280")
        addExerciseItem(emoji: "🧘", title: "瑜伽", time: "18:30 · 45分钟", calories: "+150")
        
        // 添加运动按钮
        exerciseSectionView.addSubview(addExerciseButton)
        addExerciseButton.backgroundColor = UIColor.color(.color_5ED4A4).withAlphaComponent(0.1)
        addExerciseButton.layer.cornerRadius = 16.fit()
        addExerciseButton.setTitle("+ 记录运动数据", for: .normal)
        addExerciseButton.setTitleColor(UIColor.color(.color_5ED4A4), for: .normal)
        addExerciseButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.fit(), weight: .medium)
    }
    
    private func setupChartSection() {
        contentView.addSubview(chartSectionView)
        
        chartSectionView.backgroundColor = UIColor.color(.color_FFFFFF)
        chartSectionView.layer.cornerRadius = 16.fit()
        chartSectionView.layer.shadowColor = UIColor.black.cgColor
        chartSectionView.layer.shadowOpacity = 0.05
        chartSectionView.layer.shadowOffset = CGSize(width: 0, height: 2.fit())
        chartSectionView.layer.shadowRadius = 4.fit()
        
        // 标题和周期选择
        chartSectionView.addSubview(chartTitleLabel)
        chartSectionView.addSubview(chartPeriodStackView)
        
        chartTitleLabel.text = "本周热量趋势"
        chartTitleLabel.font = UIFont.systemFont(ofSize: 18.fit(), weight: .medium)
        chartTitleLabel.textColor = UIColor.color(.color_0A0A0A)
        
        chartPeriodStackView.axis = .horizontal
        chartPeriodStackView.spacing = 8.fit()
        chartPeriodStackView.distribution = .fillEqually
        
        // 添加周期按钮
        let periods = ["季度", "月", "周"]
        for (index, period) in periods.enumerated() {
            let button = UIButton()
            button.setTitle(period, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14.fit())
            button.layer.cornerRadius = 8.fit()
            
            if index == 2 { // 选中"周"
                button.backgroundColor = UIColor.color(.color_5ED4A4)
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = UIColor.clear
                button.setTitleColor(UIColor.color(.color_6A7282), for: .normal)
            }
            
            chartPeriodStackView.addArrangedSubview(button)
        }
        
        // 图表视图
        chartSectionView.addSubview(chartView)
        chartView.backgroundColor = UIColor.color(.color_F3F4F6)
        chartView.layer.cornerRadius = 8.fit()
        
        // 图表描述
        chartSectionView.addSubview(chartDescriptionLabel)
        chartDescriptionLabel.text = "正值表示热量盈余，负值表示热量赤字"
        chartDescriptionLabel.font = UIFont.systemFont(ofSize: 12.fit())
        chartDescriptionLabel.textColor = UIColor.color(.color_99A1AF)
        chartDescriptionLabel.textAlignment = .center
    }
    

    
    // MARK: - Helper Methods
    private func addFoodItem(emoji: String, title: String, time: String, calories: String) {
        let itemView = UIView()
        itemView.backgroundColor = UIColor.color(.color_FFFFFF)
        itemView.layer.cornerRadius = 16.fit()
        itemView.layer.shadowColor = UIColor.black.cgColor
        itemView.layer.shadowOpacity = 0.05
        itemView.layer.shadowOffset = CGSize(width: 0, height: 1.fit())
        itemView.layer.shadowRadius = 3.fit()
        
        let emojiLabel = UILabel()
        let titleLabel = UILabel()
        let timeLabel = UILabel()
        let calorieLabel = UILabel()
        let unitLabel = UILabel()
        
        itemView.addSubview(emojiLabel)
        itemView.addSubview(titleLabel)
        itemView.addSubview(timeLabel)
        itemView.addSubview(calorieLabel)
        itemView.addSubview(unitLabel)
        
        emojiLabel.text = emoji
        emojiLabel.font = UIFont.systemFont(ofSize: 30.fit())
        
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14.fit(), weight: .medium)
        titleLabel.textColor = UIColor.color(.color_0A0A0A)
        
        timeLabel.text = time
        timeLabel.font = UIFont.systemFont(ofSize: 12.fit())
        timeLabel.textColor = UIColor.color(.color_99A1AF)
        
        calorieLabel.text = calories
        calorieLabel.font = UIFont.systemFont(ofSize: 16.fit(), weight: .medium)
        calorieLabel.textColor = UIColor.color(.color_FF9F6E)
        
        unitLabel.text = "kcal"
        unitLabel.font = UIFont.systemFont(ofSize: 12.fit())
        unitLabel.textColor = UIColor.color(.color_99A1AF)
        
        emojiLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.fit())
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30.fit())
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(emojiLabel.snp.right).offset(12.fit())
            make.top.equalToSuperview().offset(16.fit())
            make.right.lessThanOrEqualTo(calorieLabel.snp.left).offset(-12.fit())
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4.fit())
            make.bottom.equalToSuperview().offset(-16.fit())
        }
        
        calorieLabel.snp.makeConstraints { make in
            make.right.equalTo(unitLabel.snp.left).offset(-4.fit())
            make.centerY.equalToSuperview()
        }
        
        unitLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.fit())
            make.centerY.equalTo(calorieLabel)
        }
        
        itemView.snp.makeConstraints { make in
            make.height.equalTo(68.fit())
        }
        
        foodListStackView.addArrangedSubview(itemView)
    }
    
    private func addExerciseItem(emoji: String, title: String, time: String, calories: String) {
        let itemView = UIView()
        itemView.backgroundColor = UIColor.color(.color_FFFFFF)
        itemView.layer.cornerRadius = 16.fit()
        itemView.layer.shadowColor = UIColor.black.cgColor
        itemView.layer.shadowOpacity = 0.05
        itemView.layer.shadowOffset = CGSize(width: 0, height: 1.fit())
        itemView.layer.shadowRadius = 3.fit()
        
        let emojiLabel = UILabel()
        let titleLabel = UILabel()
        let timeLabel = UILabel()
        let calorieLabel = UILabel()
        let unitLabel = UILabel()
        
        itemView.addSubview(emojiLabel)
        itemView.addSubview(titleLabel)
        itemView.addSubview(timeLabel)
        itemView.addSubview(calorieLabel)
        itemView.addSubview(unitLabel)
        
        emojiLabel.text = emoji
        emojiLabel.font = UIFont.systemFont(ofSize: 30.fit())
        
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14.fit(), weight: .medium)
        titleLabel.textColor = UIColor.color(.color_0A0A0A)
        
        timeLabel.text = time
        timeLabel.font = UIFont.systemFont(ofSize: 12.fit())
        timeLabel.textColor = UIColor.color(.color_99A1AF)
        
        calorieLabel.text = calories
        calorieLabel.font = UIFont.systemFont(ofSize: 16.fit(), weight: .medium)
        calorieLabel.textColor = UIColor.color(.color_5ED4A4)
        
        unitLabel.text = "kcal"
        unitLabel.font = UIFont.systemFont(ofSize: 12.fit())
        unitLabel.textColor = UIColor.color(.color_99A1AF)
        
        emojiLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.fit())
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30.fit())
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(emojiLabel.snp.right).offset(12.fit())
            make.top.equalToSuperview().offset(16.fit())
            make.right.lessThanOrEqualTo(calorieLabel.snp.left).offset(-12.fit())
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4.fit())
            make.bottom.equalToSuperview().offset(-16.fit())
        }
        
        calorieLabel.snp.makeConstraints { make in
            make.right.equalTo(unitLabel.snp.left).offset(-4.fit())
            make.centerY.equalToSuperview()
        }
        
        unitLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.fit())
            make.centerY.equalTo(calorieLabel)
        }
        
        itemView.snp.makeConstraints { make in
            make.height.equalTo(68.fit())
        }
        
        exerciseListStackView.addArrangedSubview(itemView)
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
        
        // 问候语约束
        greetingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16.fit())
            make.left.equalToSuperview().offset(24.fit())
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(greetingLabel.snp.bottom).offset(8.fit())
            make.left.equalTo(greetingLabel)
        }
        
        // 热量卡片约束
        calorieCardView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24.fit())
            make.left.equalToSuperview().offset(24.fit())
            make.right.equalToSuperview().offset(-24.fit())
            make.height.equalTo(290.fit())
        }
        
        // 记录体重按钮约束
        recordWeightButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16.fit())
            make.right.equalToSuperview().offset(-16.fit())
            make.width.equalTo(93.fit())
            make.height.equalTo(28.fit())
        }
        
        // 剩余热量标题约束
        remainingCalorieLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48.fit())
            make.centerX.equalToSuperview()
        }
        
        // 热量数值约束
        calorieValueLabel.snp.makeConstraints { make in
            make.top.equalTo(remainingCalorieLabel.snp.bottom).offset(4.fit())
            make.centerX.equalToSuperview().offset(-15.fit())
        }
        
        calorieUnitLabel.snp.makeConstraints { make in
            make.left.equalTo(calorieValueLabel.snp.right).offset(8.fit())
            make.bottom.equalTo(calorieValueLabel).offset(-8.fit())
        }
        
        // 进度条约束
        progressView.snp.makeConstraints { make in
            make.top.equalTo(calorieValueLabel.snp.bottom).offset(16.fit())
            make.left.equalToSuperview().offset(24.fit())
            make.right.equalToSuperview().offset(-24.fit())
            make.height.equalTo(12.fit())
        }
        
        progressBar.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        // 指示器约束
        intakeIndicatorView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(8.fit())
            make.left.equalTo(progressView)
            make.width.height.equalTo(12.fit())
        }
        
        intakeLabel.snp.makeConstraints { make in
            make.left.equalTo(intakeIndicatorView.snp.right).offset(8.fit())
            make.centerY.equalTo(intakeIndicatorView)
        }
        
        burnIndicatorView.snp.makeConstraints { make in
            make.centerY.equalTo(intakeIndicatorView)
            make.right.equalTo(burnLabel.snp.left).offset(-8.fit())
            make.width.height.equalTo(12.fit())
        }
        
        burnLabel.snp.makeConstraints { make in
            make.right.equalTo(progressView)
            make.centerY.equalTo(intakeIndicatorView)
        }
        
        // 统计卡片约束
        intakeStatsView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24.fit())
            make.left.equalToSuperview().offset(24.fit())
            make.width.equalTo(84.fit())
            make.height.equalTo(84.fit())
        }
        
        burnStatsView.snp.makeConstraints { make in
            make.centerY.equalTo(intakeStatsView)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(84.fit())
        }
        
        targetStatsView.snp.makeConstraints { make in
            make.centerY.equalTo(intakeStatsView)
            make.right.equalToSuperview().offset(-24.fit())
            make.width.height.equalTo(84.fit())
        }
        
        // 食物部分约束
        foodSectionView.snp.makeConstraints { make in
            make.top.equalTo(calorieCardView.snp.bottom).offset(24.fit())
            make.left.right.equalToSuperview()
        }
        
        foodTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24.fit())
        }
        
        foodCalorieLabel.snp.makeConstraints { make in
            make.centerY.equalTo(foodTitleLabel)
            make.right.equalToSuperview().offset(-24.fit())
        }
        
        foodListStackView.snp.makeConstraints { make in
            make.top.equalTo(foodTitleLabel.snp.bottom).offset(12.fit())
            make.left.equalToSuperview().offset(24.fit())
            make.right.equalToSuperview().offset(-24.fit())
        }
        
        addFoodButton.snp.makeConstraints { make in
            make.top.equalTo(foodListStackView.snp.bottom).offset(12.fit())
            make.left.right.equalTo(foodListStackView)
            make.height.equalTo(52.fit())
            make.bottom.equalToSuperview()
        }
        
        // 运动部分约束
        exerciseSectionView.snp.makeConstraints { make in
            make.top.equalTo(foodSectionView.snp.bottom).offset(24.fit())
            make.left.right.equalToSuperview()
        }
        
        exerciseTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24.fit())
        }
        
        exerciseCalorieLabel.snp.makeConstraints { make in
            make.centerY.equalTo(exerciseTitleLabel)
            make.right.equalToSuperview().offset(-24.fit())
        }
        
        exerciseListStackView.snp.makeConstraints { make in
            make.top.equalTo(exerciseTitleLabel.snp.bottom).offset(12.fit())
            make.left.equalToSuperview().offset(24.fit())
            make.right.equalToSuperview().offset(-24.fit())
        }
        
        addExerciseButton.snp.makeConstraints { make in
            make.top.equalTo(exerciseListStackView.snp.bottom).offset(12.fit())
            make.left.right.equalTo(exerciseListStackView)
            make.height.equalTo(52.fit())
            make.bottom.equalToSuperview()
        }
        
        // 图表部分约束
        chartSectionView.snp.makeConstraints { make in
            make.top.equalTo(exerciseSectionView.snp.bottom).offset(24.fit())
            make.left.equalToSuperview().offset(24.fit())
            make.right.equalToSuperview().offset(-24.fit())
            make.height.equalTo(280.fit())
        }
        
        chartTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24.fit())
            make.left.equalToSuperview().offset(24.fit())
        }
        
        chartPeriodStackView.snp.makeConstraints { make in
            make.centerY.equalTo(chartTitleLabel)
            make.right.equalToSuperview().offset(-24.fit())
            make.width.equalTo(120.fit())
            make.height.equalTo(32.fit())
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(chartTitleLabel.snp.bottom).offset(16.fit())
            make.left.equalToSuperview().offset(24.fit())
            make.right.equalToSuperview().offset(-24.fit())
            make.height.equalTo(160.fit())
        }
        
        chartDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(12.fit())
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-24.fit())
        }
        
        // 设置contentView的底部约束
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(chartSectionView.snp.bottom).offset(24.fit())
        }
    }
    
    private func setupData() {
        // 这里可以设置初始数据或绑定ViewModel
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 设置渐变背景
        if let gradientLayer = calorieCardView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = calorieCardView.bounds
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
}
