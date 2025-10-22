//
//  ProfileViewModel.swift
//  DailyEnergy
//
//  Created by AI Assistant on 2024/12/21.
//

import Foundation

// MARK: - 临时数据结构（使用服务Model的简化版本）
struct UIUserProfile {
    var id: Int = 0
    var phone: String = ""
    var nickname: String = ""
    var avatar: String = ""
    var gender: Int = 0 // 0未知 1男 2女
    var age: Int = 0
    var height: Double = 0.0
    var weight: Double = 0.0
    var targetWeight: Double = 0.0
    var basalMetabolism: Double = 0.0
    var activityLevel: String = ""
    var userType: String = "normal"
    var createdAt: String = ""
    var updatedAt: String = ""
    
    var weightLoss: Double {
        return max(0, weight - targetWeight)
    }
    
    var weightProgress: Double {
        let totalWeightToLose = weight - targetWeight
        let weightLost = weight - targetWeight // 这里应该是初始体重 - 当前体重
        return totalWeightToLose > 0 ? min(weightLost / totalWeightToLose, 1.0) : 0.0
    }
}

// MARK: - UI相关枚举
enum UIGender: Int, CaseIterable {
    case unknown = 0
    case male = 1
    case female = 2
    
    var displayName: String {
        switch self {
        case .unknown: return "未知"
        case .male: return "男"
        case .female: return "女"
        }
    }
}

enum UIActivityLevel: String, CaseIterable {
    case sedentary = "sedentary"
    case lightlyActive = "lightly_active"
    case moderatelyActive = "moderately_active"
    case veryActive = "very_active"
    case extraActive = "extra_active"
    
    var displayName: String {
        switch self {
        case .sedentary: return "久坐"
        case .lightlyActive: return "轻度活跃"
        case .moderatelyActive: return "中度活跃"
        case .veryActive: return "高度活跃"
        case .extraActive: return "极度活跃"
        }
    }
    
    var multiplier: Double {
        switch self {
        case .sedentary: return 1.2
        case .lightlyActive: return 1.375
        case .moderatelyActive: return 1.55
        case .veryActive: return 1.725
        case .extraActive: return 1.9
        }
    }
}

enum UIWeightGoal: String, CaseIterable {
    case lose = "lose"
    case maintain = "maintain"
    case gain = "gain"
    
    var displayName: String {
        switch self {
        case .lose: return "减重"
        case .maintain: return "维持"
        case .gain: return "增重"
        }
    }
}

struct UIUserStats {
    let checkinDays: Int
    let weightLoss: Double
    let usageDays: Int
    let totalCaloriesBurned: Int
    let totalCaloriesConsumed: Int
    let averageDailyCalories: Int
}

struct UIWeightGoalInfo {
    let currentWeight: Double
    let targetWeight: Double
    let startWeight: Double
    let targetDate: Date?
    let progress: Double
    
    var remainingWeight: Double {
        return max(0, currentWeight - targetWeight)
    }
    
    var weightLost: Double {
        return max(0, startWeight - currentWeight)
    }
}

struct UISettingsMenuItem {
    let id: String
    let title: String
    let iconColor: String
    let type: UISettingsMenuType
}

enum UISettingsMenuType {
    case basicInfo
    case goalSetting
    case notification
    case privacy
    case help
    
    var title: String {
        switch self {
        case .basicInfo: return "基本信息"
        case .goalSetting: return "目标设置"
        case .notification: return "通知设置"
        case .privacy: return "隐私设置"
        case .help: return "帮助与支持"
        }
    }
}

// MARK: - ProfileViewModel
class ProfileViewModel {
    
    // MARK: - Properties
    private(set) var userProfile: UIUserProfile
    private(set) var userStats: UIUserStats
    private(set) var weightGoalInfo: UIWeightGoalInfo
    private(set) var settingsMenuItems: [UISettingsMenuItem] = []
    
    // MARK: - Callbacks
    var onProfileUpdated: (() -> Void)?
    var onStatsUpdated: (() -> Void)?
    var onWeightGoalUpdated: (() -> Void)?
    var onDataUpdated: (() -> Void)?
    
    // MARK: - Initialization
    init() {
        // 初始化用户资料
        self.userProfile = UIUserProfile()
        self.userProfile.id = 1
        self.userProfile.nickname = "小明"
        self.userProfile.avatar = ""
        self.userProfile.age = 28
        self.userProfile.gender = 1 // 男性
        self.userProfile.height = 175.0
        self.userProfile.weight = 72.0
        self.userProfile.targetWeight = 65.0
        self.userProfile.activityLevel = "moderately_active"
        
        // 初始化用户统计
        self.userStats = UIUserStats(
            checkinDays: 7,
            weightLoss: 2.8,
            usageDays: 24,
            totalCaloriesBurned: 8400,
            totalCaloriesConsumed: 25200,
            averageDailyCalories: 1050
        )
        
        // 初始化减重目标信息
        self.weightGoalInfo = UIWeightGoalInfo(
            currentWeight: 72.0,
            targetWeight: 65.0,
            startWeight: 75.0,
            targetDate: Calendar.current.date(byAdding: .month, value: 3, to: Date()),
            progress: 0.4
        )
        
        setupSettingsMenu()
    }
    
    // MARK: - Public Methods
    
    /// 获取用户资料
    func getUserProfile() -> UIUserProfile {
        return userProfile
    }
    
    /// 获取用户统计数据
    func getUserStats() -> UIUserStats {
        return userStats
    }
    
    /// 获取减重目标信息
    func getWeightGoalInfo() -> UIWeightGoalInfo {
        return weightGoalInfo
    }
    
    /// 获取设置菜单项
    func getSettingsMenuItems() -> [UISettingsMenuItem] {
        return settingsMenuItems
    }
    
    /// 更新用户基本信息
    func updateBasicInfo(name: String?, age: Int?, gender: UIGender?, height: Double?) {
        userProfile.nickname = name ?? userProfile.nickname
        userProfile.age = age ?? userProfile.age
        userProfile.gender = gender?.rawValue ?? userProfile.gender
        userProfile.height = height ?? userProfile.height
        
        onProfileUpdated?()
    }
    
    /// 更新体重信息
    func updateWeight(currentWeight: Double) {
        userProfile.weight = currentWeight
        
        // 更新减重目标信息
        let newProgress = calculateWeightProgress()
        weightGoalInfo = UIWeightGoalInfo(
            currentWeight: currentWeight,
            targetWeight: weightGoalInfo.targetWeight,
            startWeight: weightGoalInfo.startWeight,
            targetDate: weightGoalInfo.targetDate,
            progress: newProgress
        )
        
        onProfileUpdated?()
        onWeightGoalUpdated?()
    }
    
    /// 更新目标体重
    func updateTargetWeight(_ targetWeight: Double) {
        userProfile.targetWeight = targetWeight
        
        weightGoalInfo = UIWeightGoalInfo(
            currentWeight: weightGoalInfo.currentWeight,
            targetWeight: targetWeight,
            startWeight: weightGoalInfo.startWeight,
            targetDate: weightGoalInfo.targetDate,
            progress: calculateWeightProgress()
        )
        
        onProfileUpdated?()
        onWeightGoalUpdated?()
    }
    
    /// 更新活动水平
    func updateActivityLevel(_ activityLevel: UIActivityLevel) {
        userProfile.activityLevel = activityLevel.rawValue
        onProfileUpdated?()
    }
    
    /// 更新减重目标
    func updateWeightGoal(_ goal: UIWeightGoal) {
        // 这里可以添加目标相关的逻辑
        onProfileUpdated?()
    }
    
    /// 刷新数据
    func refreshData() {
        // 这里可以从服务器或本地存储刷新数据
        onDataUpdated?()
    }
    
    // MARK: - Formatting Methods
    
    /// 格式化年龄和性别显示
    func formatAgeGender() -> String {
        let gender = UIGender(rawValue: userProfile.gender) ?? .unknown
        return "\(gender.displayName) · \(userProfile.age)岁"
    }
    
    /// 格式化身高显示
    func formatHeight() -> String {
        return "\(Int(userProfile.height))cm"
    }
    
    /// 格式化当前体重显示
    func formatCurrentWeight() -> String {
        return "\(Int(userProfile.weight))kg"
    }
    
    /// 格式化目标体重显示
    func formatTargetWeight() -> String {
        return "目标体重 \(Int(userProfile.targetWeight))kg"
    }
    
    /// 格式化减重进度描述
    func formatWeightGoalDescription() -> String {
        let remaining = weightGoalInfo.remainingWeight
        if remaining <= 0 {
            return "🎉 恭喜！目标已达成"
        } else {
            return "🎯 坚持下去，还需减重 \(String(format: "%.1f", remaining))kg"
        }
    }
    
    /// 格式化统计数值
    func formatStatsValue(for type: UIStatsType) -> String {
        switch type {
        case .checkinDays:
            return "\(userStats.checkinDays)"
        case .weightLoss:
            return String(format: "%.1f", userStats.weightLoss)
        case .usageDays:
            return "\(userStats.usageDays)"
        }
    }
    
    /// 格式化统计单位
    func formatStatsUnit(for type: UIStatsType) -> String {
        switch type {
        case .checkinDays:
            return "天"
        case .weightLoss:
            return "kg"
        case .usageDays:
            return "天"
        }
    }
    
    /// 格式化统计标题
    func formatStatsTitle(for type: UIStatsType) -> String {
        switch type {
        case .checkinDays:
            return "连续打卡"
        case .weightLoss:
            return "已减重量"
        case .usageDays:
            return "使用天数"
        }
    }
    
    // MARK: - Calculation Methods
    
    /// 计算基础代谢率 (BMR)
    func calculateBMR() -> Double {
        // 使用Mifflin-St Jeor方程
        let bmr: Double
        let gender = UIGender(rawValue: userProfile.gender) ?? .unknown
        
        switch gender {
        case .male:
            bmr = 10 * userProfile.weight + 6.25 * userProfile.height - 5 * Double(userProfile.age) + 5
        case .female:
            bmr = 10 * userProfile.weight + 6.25 * userProfile.height - 5 * Double(userProfile.age) - 161
        case .unknown:
            // 使用男性公式作为默认值
            bmr = 10 * userProfile.weight + 6.25 * userProfile.height - 5 * Double(userProfile.age) + 5
        }
        
        return bmr
    }
    
    /// 计算每日总消耗热量 (TDEE)
    func calculateTDEE() -> Double {
        let activityLevel = UIActivityLevel(rawValue: userProfile.activityLevel) ?? .moderatelyActive
        return calculateBMR() * activityLevel.multiplier
    }
    
    /// 计算建议每日热量摄入
    func calculateRecommendedCalories() -> Int {
        let tdee = calculateTDEE()
        // 默认减重目标，每天减少500卡路里
        return Int(tdee - 500)
    }
    
    /// 计算BMI
    func calculateBMI() -> Double {
        let heightInMeters = userProfile.height / 100
        return userProfile.weight / (heightInMeters * heightInMeters)
    }
    
    /// 获取BMI分类
    func getBMICategory() -> String {
        let bmi = calculateBMI()
        
        switch bmi {
        case ..<18.5:
            return "偏瘦"
        case 18.5..<24:
            return "正常"
        case 24..<28:
            return "超重"
        default:
            return "肥胖"
        }
    }
    
    // MARK: - Private Methods
    
    private func setupSettingsMenu() {
        settingsMenuItems = [
            UISettingsMenuItem(
                id: "basic_info",
                title: "基本信息",
                iconColor: "color_5ED4A4",
                type: .basicInfo
            ),
            UISettingsMenuItem(
                id: "goal_setting",
                title: "目标设置",
                iconColor: "color_FF9F6E",
                type: .goalSetting
            ),
            UISettingsMenuItem(
                id: "notification",
                title: "通知设置",
                iconColor: "color_A8E6CF",
                type: .notification
            ),
            UISettingsMenuItem(
                id: "privacy",
                title: "隐私设置",
                iconColor: "color_99A1AF",
                type: .privacy
            ),
            UISettingsMenuItem(
                id: "help",
                title: "帮助与支持",
                iconColor: "color_6A7282",
                type: .help
            )
        ]
    }
    
    private func calculateWeightProgress() -> Double {
        let totalWeightToLose = weightGoalInfo.startWeight - userProfile.targetWeight
        let weightLost = weightGoalInfo.startWeight - userProfile.weight
        
        if totalWeightToLose <= 0 {
            return 1.0
        }
        
        return min(max(weightLost / totalWeightToLose, 0.0), 1.0)
    }
}

// MARK: - Supporting Types
enum UIStatsType {
    case checkinDays
    case weightLoss
    case usageDays
}

// MARK: - Extensions
extension ProfileViewModel {
    
    /// 获取用户成就列表
    func getUserAchievements() -> [UIAchievement] {
        var achievements: [UIAchievement] = []
        
        // 连续打卡成就
        if userStats.checkinDays >= 7 {
            achievements.append(UIAchievement(
                id: "checkin_7",
                title: "坚持一周",
                description: "连续打卡7天",
                iconName: "checkin_icon",
                isUnlocked: true
            ))
        }
        
        // 减重成就
        if userStats.weightLoss >= 2.0 {
            achievements.append(UIAchievement(
                id: "weight_loss_2",
                title: "减重达人",
                description: "成功减重2kg",
                iconName: "weight_loss_icon",
                isUnlocked: true
            ))
        }
        
        // 使用天数成就
        if userStats.usageDays >= 30 {
            achievements.append(UIAchievement(
                id: "usage_30",
                title: "忠实用户",
                description: "使用应用30天",
                iconName: "usage_days_icon",
                isUnlocked: true
            ))
        }
        
        return achievements
    }
    
    /// 获取健康建议
    func getHealthRecommendations() -> [UIHealthRecommendation] {
        var recommendations: [UIHealthRecommendation] = []
        
        let bmi = calculateBMI()
        
        // 基于BMI的建议
        if bmi < 18.5 {
            recommendations.append(UIHealthRecommendation(
                type: .nutrition,
                title: "增加营养摄入",
                description: "您的BMI偏低，建议增加健康的热量摄入"
            ))
        } else if bmi >= 24 {
            recommendations.append(UIHealthRecommendation(
                type: .exercise,
                title: "增加运动量",
                description: "建议每周进行至少150分钟的中等强度运动"
            ))
        }
        
        // 基于活动水平的建议
        let activityLevel = UIActivityLevel(rawValue: userProfile.activityLevel) ?? .moderatelyActive
        if activityLevel == .sedentary {
            recommendations.append(UIHealthRecommendation(
                type: .lifestyle,
                title: "增加日常活动",
                description: "尝试每小时起身活动5-10分钟"
            ))
        }
        
        return recommendations
    }
}

// MARK: - Supporting Models
struct UIAchievement {
    let id: String
    let title: String
    let description: String
    let iconName: String
    let isUnlocked: Bool
}

struct UIHealthRecommendation {
    let type: UIRecommendationType
    let title: String
    let description: String
}

enum UIRecommendationType {
    case nutrition
    case exercise
    case lifestyle
    case sleep
}