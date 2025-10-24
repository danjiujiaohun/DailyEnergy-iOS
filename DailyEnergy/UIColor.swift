//
//  UIColor.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2023/8/12.
//

import Foundation
import UIKit

extension Bundle {
    static let Common = Bundle.main.bundle("Common")
}

public extension UIColor {
    static func color(_ name: ColorName) -> UIColor {
        let colorName: String = {
            return name.rawValue
        }()
        
        return UIColor(named: colorName, in: .Common, compatibleWith: nil) ?? UIColor.white
    }
}

public enum ColorName:String,CaseIterable {
    /// 0xFFFFFF
    case color_FFFFFF
    
    /// 0x000000
    case color_000000
    
    /// 0x24292B
    case color_24292B
    
    /// 0x9DA2A5
    case color_9DA2A5
    
    /// 0xFF453A 警告红色
    case color_FF453A
    
    /// 0x0A0A0A 主要文字颜色
    case color_0A0A0A
    
    /// 0x6A7282 次要文字颜色
    case color_6A7282
    
    /// 0x4A5565 辅助文字颜色
    case color_4A5565
    
    /// 0x99A1AF 提示文字颜色
    case color_99A1AF
    
    /// 0x5ED4A4 主要绿色
    case color_5ED4A4
    
    /// 0xA8E6CF 浅绿色
    case color_A8E6CF
    
    /// 0xFF9F6E 橙色
    case color_FF9F6E
    
    /// 0xF3F4F6 背景灰色
    case color_F3F4F6
    
    /// 0xF0FBF7 浅绿背景
    case color_F0FBF7
    
    /// 0xDCEFEA 渐变绿色
    case color_DCEFEA
    
    /// 0xF5FAF8 渐变中间色
    case color_F5FAF8
    
    /// 0x030213 深色进度条
    case color_030213
    
    /// 0xFFF5F0 橙色背景
    case color_FFF5F0
    
    /// 0xF5F3FF 紫色背景
    case color_F5F3FF
    
    /// 0xE9D4FF 紫色边框
    case color_E9D4FF
    
    /// 0xFFB84D 橙色渐变
    case color_FFB84D
    
    /// 0x6B73FF 紫色
    case color_6B73FF
}
