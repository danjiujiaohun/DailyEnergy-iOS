//
//  CalorieModels.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2024/12/30.
//

import Foundation
import HandyJSON

// MARK: - 热量相关模型

/// 热量记录请求
struct CalorieRecordRequest: HandyJSON {
    var foodName: String = ""
    var quantity: Double = 0.0
    var unit: String = ""
    var calories: Double = 0.0
    var mealType: String = ""
    var recordTime: String = ""
    var imageUrl: String?
    var protein: Double?
    var carbs: Double?
    var fat: Double?
    var fiber: Double?
    var sugar: Double?
    var sodium: Double?
    var notes: String?
    
    init() {}
    
    init(foodName: String, quantity: Double, unit: String, calories: Double, mealType: String, recordTime: String) {
        self.foodName = foodName
        self.quantity = quantity
        self.unit = unit
        self.calories = calories
        self.mealType = mealType
        self.recordTime = recordTime
    }
}

/// 食物摄入请求
struct FoodIntakeRequest: HandyJSON {
    var foodName: String = ""
    var weight: Double = 0.0
    var calories: Double = 0.0
    var mealType: String = ""
    var recordTime: String = ""
    
    init() {}
    
    init(foodName: String, weight: Double, calories: Double, mealType: String, recordTime: String) {
        self.foodName = foodName
        self.weight = weight
        self.calories = calories
        self.mealType = mealType
        self.recordTime = recordTime
    }
}

/// 运动消耗请求
struct ExerciseRequest: HandyJSON {
    var exerciseName: String = ""
    var duration: Int = 0
    var calories: Double = 0.0
    var recordTime: String = ""
    
    init() {}
    
    init(exerciseName: String, duration: Int, calories: Double, recordTime: String) {
        self.exerciseName = exerciseName
        self.duration = duration
        self.calories = calories
        self.recordTime = recordTime
    }
}

/// 运动记录请求（与后端ExerciseRecordRequest匹配）
struct ExerciseRecordRequest: HandyJSON {
    var exerciseName: String = ""
    var duration: Int = 0
    var caloriesBurned: Double = 0.0
    var exerciseType: String?
    var intensity: String?
    var recordDate: String = ""
    var notes: String?
    
    init() {}
    
    init(exerciseName: String, duration: Int, caloriesBurned: Double, recordDate: String, 
         exerciseType: String? = nil, intensity: String? = nil, notes: String? = nil) {
        self.exerciseName = exerciseName
        self.duration = duration
        self.caloriesBurned = caloriesBurned
        self.recordDate = recordDate
        self.exerciseType = exerciseType
        self.intensity = intensity
        self.notes = notes
    }
}

/// 热量记录
struct CalorieRecord: HandyJSON {
    var id: Int = 0
    var userId: Int = 0
    var recordType: String = "" // food食物摄入 exercise运动消耗
    var foodId: Int?
    var exerciseId: Int?
    var weight: Double?
    var duration: Int?
    var calories: Double = 0.0
    var mealType: String?
    var recordDate: String = ""
    var createdAt: String = ""
    
    init() {}
}

/// 今日热量概览
struct TodaySummary: HandyJSON {
    var basalMetabolism: Double = 0.0 // 基础代谢
    var foodIntake: Double = 0.0 // 食物摄入
    var exerciseConsumption: Double = 0.0 // 运动消耗
    var remainingCalories: Double = 0.0 // 剩余热量
    var calorieDeficit: Double = 0.0 // 热量缺口
    var todayWeight: Double? // 今日体重
    var targetCalories: Double = 0.0 // 目标热量
    
    init() {}
}

/// 热量历史记录
struct CalorieHistory: HandyJSON {
    var records: [CalorieRecord] = []
    var totalCalories: Double = 0.0
    var totalExercise: Double = 0.0
    var netCalories: Double = 0.0
    
    init() {}
}

/// 食物信息
struct FoodInfo: HandyJSON {
    var id: Int = 0
    var name: String = ""
    var caloriesPer100g: Double = 0.0
    var category: String = ""
    var imageUrl: String = ""
    var protein: Double = 0.0
    var fat: Double = 0.0
    var carbs: Double = 0.0
    
    init() {}
}

/// 运动信息
struct ExerciseInfo: HandyJSON {
    var id: Int = 0
    var name: String = ""
    var caloriesPer30min: Double = 0.0
    var category: String = ""
    
    init() {}
}

/// 热量趋势数据
struct CalorieTrend: HandyJSON {
    var date: String = ""
    var intake: Double = 0.0
    var consumption: Double = 0.0
    var deficit: Double = 0.0
    var weight: Double?
    
    init() {}
}

/// 热量趋势响应
struct CalorieTrendResponse: HandyJSON {
    var trends: [CalorieTrend] = []
    var period: String = ""
    var averageDeficit: Double = 0.0
    var totalDeficit: Double = 0.0
    
    init() {}
}

/// 体重趋势响应
struct WeightTrendResponse: HandyJSON {
    var weights: [WeightRecord] = []
    var period: String = ""
    var weightChange: Double = 0.0
    var averageWeight: Double = 0.0
    
    init() {}
}