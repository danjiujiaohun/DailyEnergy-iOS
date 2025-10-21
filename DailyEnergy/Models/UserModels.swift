//
//  UserModels.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2024/12/30.
//

import Foundation
import HandyJSON

// MARK: - 用户相关模型

/// 用户基础信息
struct UserInfo: HandyJSON, Codable {
    var id: Int = 0
    var phone: String = ""
    var nickname: String = ""
    var avatar: String = ""
    var gender: Int = 0 // 0未知 1男 2女
    var age: Int = 0
    var height: Double = 0.0
    var weight: Double = 0.0
    var basalMetabolism: Double = 0.0
    var userType: String = "normal" // normal普通用户 vip会员用户
    var createdAt: String = ""
    var updatedAt: String = ""
    
    init() {}
}

/// 用户详细信息
struct UserProfile: HandyJSON {
    var id: Int = 0
    var phone: String = ""
    var nickname: String = ""
    var avatar: String = ""
    var gender: Int = 0
    var age: Int = 0
    var height: Double = 0.0
    var weight: Double = 0.0
    var targetWeight: Double = 0.0
    var basalMetabolism: Double = 0.0
    var activityLevel: String = ""
    var userType: String = "normal"
    var createdAt: String = ""
    var updatedAt: String = ""
    
    init() {}
}

/// 用户更新请求
struct UserUpdateRequest: HandyJSON {
    var nickname: String?
    var gender: Int?
    var age: Int?
    var height: Double?
    var weight: Double?
    var targetWeight: Double?
    var activityLevel: String?
    
    init() {}
    
    init(nickname: String? = nil, gender: Int? = nil, age: Int? = nil, 
         height: Double? = nil, weight: Double? = nil, targetWeight: Double? = nil, 
         activityLevel: String? = nil) {
        self.nickname = nickname
        self.gender = gender
        self.age = age
        self.height = height
        self.weight = weight
        self.targetWeight = targetWeight
        self.activityLevel = activityLevel
    }
}

/// 用户目标设置
struct UserGoal: HandyJSON {
    var id: Int = 0
    var userId: Int = 0
    var targetWeight: Double = 0.0
    var dailyCalorieDeficit: Double = 0.0
    var targetDate: String = ""
    var createdAt: String = ""
    var updatedAt: String = ""
    
    init() {}
}

/// 体重记录
struct WeightRecord: HandyJSON {
    var id: Int = 0
    var userId: Int = 0
    var weight: Double = 0.0
    var recordDate: String = ""
    var createdAt: String = ""
    
    init() {}
}

/// 上传响应
struct UploadResponse: HandyJSON {
    var url: String = ""
    var fileName: String = ""
    var fileSize: Int = 0
    
    init() {}
}

/// 删除账户响应
struct DeleteAccountResponse: HandyJSON {
    var success: Bool = false
    var message: String = ""
    
    init() {}
}
