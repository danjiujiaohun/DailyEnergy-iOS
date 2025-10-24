//
//  AuthModels.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2024/12/30.
//

import Foundation
import HandyJSON

// MARK: - 认证相关模型



/// 登录响应
struct LoginResponse: HandyJSON {
    var token: String = ""
    var userInfo: UserInfo?
    var isFirstLogin: Bool = false
    
    init() {}
}

/// 微信登录请求
struct WechatLoginRequest: HandyJSON {
    var code: String = ""
    
    init() {}
    
    init(code: String) {
        self.code = code
    }
}

/// Apple登录请求
struct AppleLoginRequest: HandyJSON {
    var identityToken: String = ""
    var authorizationCode: String = ""
    
    init() {}
    
    init(identityToken: String, authorizationCode: String) {
        self.identityToken = identityToken
        self.authorizationCode = authorizationCode
    }
}

/// 刷新Token响应
struct RefreshTokenResponse: HandyJSON {
    var token: String = ""
    var expiresIn: Int = 0
    
    init() {}
}

/// 登出响应
struct LogoutResponse: HandyJSON {
    var success: Bool = false
    var message: String = ""
    
    init() {}
}