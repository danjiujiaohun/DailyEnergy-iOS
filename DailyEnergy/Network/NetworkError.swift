//
//  NetworkError.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2024/12/30.
//

import Foundation
import HandyJSON

/// 网络错误枚举
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case encodingError
    case networkError(Error)
    case serverError(String?)
    case unauthorized
    case forbidden
    case notFound
    case timeout
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "无效的URL"
        case .noData:
            return "没有数据"
        case .decodingError:
            return "数据解析失败"
        case .encodingError:
            return "数据编码失败"
        case .networkError(let error):
            return "网络错误: \(error.localizedDescription)"
        case .serverError(let message):
            return "服务器错误 : \(message ?? "未知错误")"
        case .unauthorized:
            return "未授权访问"
        case .forbidden:
            return "访问被禁止"
        case .notFound:
            return "资源未找到"
        case .timeout:
            return "请求超时"
        case .unknown:
            return "未知错误"
        }
    }
    
    /// 错误码
    var code: Int {
        switch self {
        case .invalidURL:
            return -1001
        case .noData:
            return -1002
        case .decodingError:
            return -1003
        case .encodingError:
            return -1004
        case .networkError:
            return -1005
        case .serverError(_):
            return 500
        case .unauthorized:
            return 401
        case .forbidden:
            return 403
        case .notFound:
            return 404
        case .timeout:
            return -1006
        case .unknown:
            return -1000
            
        }
    }
}

// MARK: - API响应模型
struct APIResponse<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var message: String = ""
    var data: T?
    var success: Bool = false
    
    /// 是否成功
    var isSuccess: Bool {
        return success && code == 200
    }
    
    init() {}
}
