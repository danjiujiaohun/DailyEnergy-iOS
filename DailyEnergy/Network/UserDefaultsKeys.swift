//
//  UserDefaultsKeys.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2024/12/30.
//

import Foundation

/// UserDefaults 键值常量
struct UserDefaultsKeys {
    /// 用户Token
    static let userToken = "user_token"
    
    /// 用户信息
    static let userInfo = "user_info"
    
    /// 是否首次登录
    static let isFirstLogin = "is_first_login"
    
    /// 用户类型
    static let userType = "user_type"
    
    /// 设备ID
    static let deviceId = "device_id"
    
    /// 推送Token
    static let pushToken = "push_token"
    
    /// 应用版本
    static let appVersion = "app_version"
    
    /// 是否已同意隐私政策
    static let hasAgreedPrivacyPolicy = "has_agreed_privacy_policy"
    
    /// 是否已同意用户协议
    static let hasAgreedUserAgreement = "has_agreed_user_agreement"
    
    /// 上次同步时间
    static let lastSyncTime = "last_sync_time"
    
    /// 缓存过期时间
    static let cacheExpireTime = "cache_expire_time"
    
    /// 是否开启推送通知
    static let pushNotificationEnabled = "push_notification_enabled"
    
    /// 是否开启声音提醒
    static let soundReminderEnabled = "sound_reminder_enabled"
    
    /// 是否开启震动提醒
    static let vibrationReminderEnabled = "vibration_reminder_enabled"
    
    /// 提醒时间设置
    static let reminderTimes = "reminder_times"
    
    /// 目标热量
    static let targetCalories = "target_calories"
    
    /// 目标体重
    static let targetWeight = "target_weight"
    
    /// 当前体重
    static let currentWeight = "current_weight"
    
    /// 身高
    static let height = "height"
    
    /// 年龄
    static let age = "age"
    
    /// 性别
    static let gender = "gender"
    
    /// 活动水平
    static let activityLevel = "activity_level"
}