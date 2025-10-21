//
//  AIModels.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2024/12/30.
//

import Foundation
import HandyJSON

// MARK: - AI相关模型

/// AI食物热量查询请求
struct FoodCaloriesRequest: HandyJSON {
    var foodName: String = ""
    var description: String?
    
    init() {}
    
    init(foodName: String, description: String? = nil) {
        self.foodName = foodName
        self.description = description
    }
}

/// AI食物热量查询响应
struct FoodCaloriesResponse: HandyJSON {
    var success: Bool = false
    var calories: Double = 0.0
    var protein: Double = 0.0
    var fat: Double = 0.0
    var carbs: Double = 0.0
    var foodName: String = ""
    var description: String = ""
    
    init() {}
}

/// AI食物识别请求
struct FoodRecognitionRequest: HandyJSON {
    var imageUrl: String = ""
    
    init() {}
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
}

/// AI食物识别响应
struct FoodRecognitionResponse: HandyJSON {
    var success: Bool = false
    var taskId: String = ""
    var status: String = "" // pending/processing/completed/failed
    var message: String = ""
    
    init() {}
}

/// AI任务状态查询响应
struct AITaskStatusResponse: HandyJSON {
    var taskId: String = ""
    var status: String = "" // pending/processing/completed/failed
    var result: FoodRecognitionResult?
    var createdAt: String = ""
    var completedAt: String?
    var errorMessage: String?
    
    init() {}
}

/// 食物识别结果
struct FoodRecognitionResult: HandyJSON {
    var foods: [RecognizedFood] = []
    var confidence: Double = 0.0
    
    init() {}
}

/// 识别到的食物
struct RecognizedFood: HandyJSON {
    var name: String = ""
    var weight: Double = 0.0 // 估算重量(g)
    var confidence: Double = 0.0 // 识别置信度
    var calories: Double = 0.0 // 估算热量
    var protein: Double = 0.0
    var fat: Double = 0.0
    var carbs: Double = 0.0
    var boundingBox: BoundingBox?
    
    init() {}
}

/// 边界框
struct BoundingBox: HandyJSON {
    var x: Double = 0.0
    var y: Double = 0.0
    var width: Double = 0.0
    var height: Double = 0.0
    
    init() {}
}

/// AI任务
struct AITask: HandyJSON {
    var id: Int = 0
    var userId: Int = 0
    var taskType: String = "" // food_recognition/food_calories
    var status: String = "" // pending/processing/completed/failed
    var requestData: String = ""
    var responseData: String = ""
    var cozeWorkflowId: String = ""
    var errorMessage: String?
    var createdAt: String = ""
    var completedAt: String?
    
    init() {}
}