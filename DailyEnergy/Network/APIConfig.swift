//
//  APIConfig.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2024/12/30.
//

import Foundation

/// API配置
struct APIConfig {
    /// 基础URL
    static let baseURL = "http://localhost:8080/api"
    
    /// 请求超时时间
    static let timeout: TimeInterval = 30.0
    
    /// 上传文件超时时间
    static let uploadTimeout: TimeInterval = 60.0
}
