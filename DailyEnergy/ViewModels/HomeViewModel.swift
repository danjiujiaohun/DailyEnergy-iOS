//
//  HomeViewModel.swift
//  DailyEnergy
//
//  Created by AI Assistant on 2024/12/21.
//

import Foundation



// MARK: - UI相关枚举和扩展
enum FoodCategory: String, CaseIterable {
    case breakfast = "breakfast"
    case lunch = "lunch"
    case dinner = "dinner"
    case snack = "snack"
    
    var displayName: String {
        switch self {
        case .breakfast: return "早餐"
        case .lunch: return "午餐"
        case .dinner: return "晚餐"
        case .snack: return "零食"
        }
    }
}

enum ExerciseType: String, CaseIterable {
    case cardio = "cardio"
    case strength = "strength"
    case flexibility = "flexibility"
    case sports = "sports"
    
    var displayName: String {
        switch self {
        case .cardio: return "有氧运动"
        case .strength: return "力量训练"
        case .flexibility: return "柔韧性训练"
        case .sports: return "运动"
        }
    }
}

enum ChartPeriod: String, CaseIterable {
    case week = "week"
    case month = "month"
    case quarter = "quarter"
    
    var displayName: String {
        switch self {
        case .week: return "周"
        case .month: return "月"
        case .quarter: return "季度"
        }
    }
}

// MARK: - UI展示用的数据结构
struct UIFoodItem {
    let id: String
    let emoji: String
    let title: String
    let time: String
    let calories: Int
    let category: FoodCategory
    
    init(id: String, emoji: String, title: String, time: String, calories: Int, category: FoodCategory) {
        self.id = id
        self.emoji = emoji
        self.title = title
        self.time = time
        self.calories = calories
        self.category = category
    }
}

struct UIExerciseItem {
    let id: String
    let emoji: String
    let title: String
    let duration: Int
    let time: String
    let calories: Int
    let type: ExerciseType
    
    init(id: String, emoji: String, title: String, duration: Int, time: String, calories: Int, type: ExerciseType) {
        self.id = id
        self.emoji = emoji
        self.title = title
        self.duration = duration
        self.time = time
        self.calories = calories
        self.type = type
    }
}

struct UIChartData {
    let period: ChartPeriod
    let data: [UIChartPoint]
}

struct UIChartPoint {
    let date: Date
    let value: Int // 热量差值（正值表示盈余，负值表示赤字）
}

// MARK: - HomeViewModel
class HomeViewModel {
    
    // MARK: - Properties
    private(set) var todaySummary: TodaySummary
    private(set) var foodItems: [UIFoodItem] = []
    private(set) var exerciseItems: [UIExerciseItem] = []
    private(set) var chartData: UIChartData
    private(set) var selectedChartPeriod: ChartPeriod = .week
    
    // MARK: - Callbacks
    var onDataUpdated: (() -> Void)?
    var onCalorieDataUpdated: (() -> Void)?
    var onFoodItemsUpdated: (() -> Void)?
    var onExerciseItemsUpdated: (() -> Void)?
    var onChartDataUpdated: (() -> Void)?
    
    // MARK: - Initialization
    init() {
        // 初始化默认数据
        self.todaySummary = TodaySummary()
        self.todaySummary.basalMetabolism = 1720
        self.todaySummary.foodIntake = 850
        self.todaySummary.exerciseConsumption = 430
        self.todaySummary.remainingCalories = 1300
        self.todaySummary.targetCalories = 1720
        
        self.chartData = UIChartData(
            period: .week,
            data: HomeViewModel.generateMockChartData(for: .week)
        )
        
        loadInitialData()
    }
    
    // MARK: - Public Methods
    
    /// 获取问候语
    func getGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 5..<12:
            return "早上好！"
        case 12..<18:
            return "下午好！"
        case 18..<22:
            return "晚上好！"
        default:
            return "夜深了！"
        }
    }
    
    /// 获取副标题
    func getSubtitle() -> String {
        return "让我们保持健康的一天"
    }
    
    /// 获取热量数据
    func getTodaySummary() -> TodaySummary {
        return todaySummary
    }
    
    /// 获取食物摄入总热量
    func getTotalFoodCalories() -> Int {
        return foodItems.reduce(0) { $0 + $1.calories }
    }
    
    /// 获取运动消耗总热量
    func getTotalExerciseCalories() -> Int {
        return exerciseItems.reduce(0) { $0 + $1.calories }
    }
    
    /// 获取食物列表
    func getFoodItems() -> [UIFoodItem] {
        return foodItems
    }
    
    /// 获取运动列表
    func getExerciseItems() -> [UIExerciseItem] {
        return exerciseItems
    }
    
    /// 获取图表数据
    func getChartData() -> UIChartData {
        return chartData
    }
    
    /// 切换图表周期
    func switchChartPeriod(to period: ChartPeriod) {
        selectedChartPeriod = period
        chartData = UIChartData(
            period: period,
            data: HomeViewModel.generateMockChartData(for: period)
        )
        onChartDataUpdated?()
    }
    
    /// 添加食物记录
    func addFoodItem(_ item: UIFoodItem) {
        foodItems.append(item)
        updateTodaySummary()
        onFoodItemsUpdated?()
        onCalorieDataUpdated?()
    }
    
    /// 删除食物记录
    func removeFoodItem(withId id: String) {
        foodItems.removeAll { $0.id == id }
        updateTodaySummary()
        onFoodItemsUpdated?()
        onCalorieDataUpdated?()
    }
    
    /// 添加运动记录
    func addExerciseItem(_ item: UIExerciseItem) {
        exerciseItems.append(item)
        updateTodaySummary()
        onExerciseItemsUpdated?()
        onCalorieDataUpdated?()
    }
    
    /// 删除运动记录
    func removeExerciseItem(withId id: String) {
        exerciseItems.removeAll { $0.id == id }
        updateTodaySummary()
        onExerciseItemsUpdated?()
        onCalorieDataUpdated?()
    }
    
    /// 刷新数据
    func refreshData() {
        loadInitialData()
        onDataUpdated?()
    }
    
    // MARK: - Private Methods
    
    private func loadInitialData() {
        // 加载示例食物数据
        foodItems = [
            UIFoodItem(
                id: UUID().uuidString,
                emoji: "🍞",
                title: "早餐 - 全麦面包",
                time: "08:30",
                calories: 320,
                category: .breakfast
            ),
            UIFoodItem(
                id: UUID().uuidString,
                emoji: "🥗",
                title: "午餐 - 鸡胸沙拉",
                time: "12:45",
                calories: 450,
                category: .lunch
            ),
            UIFoodItem(
                id: UUID().uuidString,
                emoji: "🍎",
                title: "下午茶 - 苹果",
                time: "15:20",
                calories: 80,
                category: .snack
            )
        ]
        
        // 加载示例运动数据
        exerciseItems = [
            UIExerciseItem(
                id: UUID().uuidString,
                emoji: "🏃",
                title: "晨跑",
                duration: 30,
                time: "07:00",
                calories: 280,
                type: .cardio
            ),
            UIExerciseItem(
                id: UUID().uuidString,
                emoji: "🧘",
                title: "瑜伽",
                duration: 45,
                time: "18:30",
                calories: 150,
                type: .flexibility
            )
        ]
        
        updateTodaySummary()
    }
    
    private func updateTodaySummary() {
        let totalIntake = Double(getTotalFoodCalories())
        let totalBurn = Double(getTotalExerciseCalories())
        let target = 1720.0 // 这个值应该从用户设置中获取
        let remaining = target - totalIntake + totalBurn
        
        todaySummary.foodIntake = totalIntake
        todaySummary.exerciseConsumption = totalBurn
        todaySummary.remainingCalories = remaining
        todaySummary.targetCalories = target
    }
    
    private static func generateMockChartData(for period: ChartPeriod) -> [UIChartPoint] {
        let calendar = Calendar.current
        let today = Date()
        var points: [UIChartPoint] = []
        
        switch period {
        case .week:
            // 生成过去7天的数据
            for i in 0..<7 {
                if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                    let value = Int.random(in: -200...300) // 随机热量差值
                    points.append(UIChartPoint(date: date, value: value))
                }
            }
        case .month:
            // 生成过去30天的数据（每5天一个点）
            for i in stride(from: 0, to: 30, by: 5) {
                if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                    let value = Int.random(in: -300...400)
                    points.append(UIChartPoint(date: date, value: value))
                }
            }
        case .quarter:
            // 生成过去90天的数据（每15天一个点）
            for i in stride(from: 0, to: 90, by: 15) {
                if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                    let value = Int.random(in: -400...500)
                    points.append(UIChartPoint(date: date, value: value))
                }
            }
        }
        
        return points.reversed() // 按时间顺序排列
    }
    
    // MARK: - Formatting Helpers
    
    /// 格式化热量显示
    func formatCalories(_ calories: Int) -> String {
        return "\(calories)"
    }
    
    /// 格式化时间显示
    func formatTime(_ time: String) -> String {
        return time
    }
    
    /// 格式化运动时长显示
    func formatDuration(_ duration: Int) -> String {
        return "\(duration)分钟"
    }
    
    /// 获取进度百分比
    func getProgressPercentage() -> Double {
        let progress = (todaySummary.foodIntake + todaySummary.exerciseConsumption) / todaySummary.targetCalories
        return min(progress, 1.0)
    }
    
    /// 判断是否达到目标
    func isTargetReached() -> Bool {
        return todaySummary.remainingCalories <= 0
    }
    
    /// 获取目标完成状态描述
    func getTargetStatusDescription() -> String {
        if isTargetReached() {
            return "恭喜！今日目标已达成"
        } else {
            return "继续加油，距离目标还有 \(Int(todaySummary.remainingCalories)) kcal"
        }
    }
}

// MARK: - Extensions
extension HomeViewModel {
    
    /// 获取食物分类统计
    func getFoodCategoryStats() -> [FoodCategory: Int] {
        var stats: [FoodCategory: Int] = [:]
        
        for item in foodItems {
            stats[item.category, default: 0] += item.calories
        }
        
        return stats
    }
    
    /// 获取运动类型统计
    func getExerciseTypeStats() -> [ExerciseType: Int] {
        var stats: [ExerciseType: Int] = [:]
        
        for item in exerciseItems {
            stats[item.type, default: 0] += item.calories
        }
        
        return stats
    }
    
    /// 获取今日活动总结
    func getDailySummary() -> String {
        let foodCount = foodItems.count
        let exerciseCount = exerciseItems.count
        let totalCalories = getTotalFoodCalories()
        let totalBurn = getTotalExerciseCalories()
        
        return "今日记录了 \(foodCount) 项食物摄入（\(totalCalories) kcal），\(exerciseCount) 项运动消耗（\(totalBurn) kcal）"
    }
}
