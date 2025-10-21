//
//  UIImage.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2023/8/12.
//

import Foundation
import UIKit

public extension UIImage {
    static func image(_ iconName: iconName) -> UIImage {
        UIImage(named: iconName.getName(), in: .Common, compatibleWith: nil)!
    }
}

/// 智能设备图片资源
public enum iconName: String, CaseIterable {
    /// 返回图标
    case back_icon
    /// 关闭图标
    case close_btn
    /// 个人中心_默认头像
    case avatar_default
    /// 首页图标
    case home_icon
    /// 个人中心图标
    case profile_icon
    /// 记录体重图标
    case weight_record_icon
    /// 摄入图标
    case intake_icon
    /// 消耗图标
    case burn_icon
    /// 目标图标
    case target_icon
    /// 添加图标
    case add_icon
    /// 跑步图标
    case running_icon
    /// 瑜伽图标
    case yoga_icon
    /// 基本信息图标
    case basic_info_icon
    /// 目标设置图标
    case goal_setting_icon
    /// 通知设置图标
    case notification_icon
    /// 隐私安全图标
    case privacy_icon
    /// 帮助反馈图标
    case help_icon
    /// 右箭头图标
    case arrow_right_icon
    /// 连续打卡图标
    case checkin_icon
    /// 已减重图标
    case weight_loss_icon
    /// 使用天数图标
    case usage_days_icon
    
    func getName() -> String {
        "image_" + rawValue
    }
}
