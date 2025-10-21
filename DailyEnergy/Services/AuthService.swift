//
//  AuthService.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2024/12/30.
//

import Foundation

/// 认证服务
class AuthService {
    /// 单例
    static let shared = AuthService()
    
    private let networkManager = NetworkManager.shared
    
    private init() {}
    
    // MARK: - 认证相关方法
    
    /// 发送验证码
    /// - Parameters:
    ///   - phone: 手机号
    ///   - completion: 完成回调
    func sendCode(phone: String, completion: @escaping (Result<SendCodeResponse, NetworkError>) -> Void) {
        networkManager.sendCode(phone: phone, completion: completion)
    }
    
    /// 用户登录
    /// - Parameters:
    ///   - phone: 手机号
    ///   - code: 验证码
    ///   - loginType: 登录类型
    ///   - completion: 完成回调
    func login(phone: String, code: String, loginType: String = "phone", completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        networkManager.login(phone: phone, code: code, loginType: loginType) { result in
            switch result {
            case .success(let response):
                // 保存用户信息和token
                self.saveUserInfo(response)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// 微信登录
    /// - Parameters:
    ///   - code: 微信授权码
    ///   - completion: 完成回调
    func wechatLogin(code: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .wechatLogin(code: code),
            responseType: LoginResponse.self
        ) { result in
            switch result {
            case .success(let response):
                self.saveUserInfo(response)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Apple登录
    /// - Parameters:
    ///   - identityToken: Apple身份令牌
    ///   - authorizationCode: Apple授权码
    ///   - completion: 完成回调
    func appleLogin(identityToken: String, authorizationCode: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .appleLogin(identityToken: identityToken),
            responseType: LoginResponse.self
        ) { result in
            switch result {
            case .success(let response):
                self.saveUserInfo(response)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// 刷新Token
    /// - Parameter completion: 完成回调
    func refreshToken(completion: @escaping (Result<RefreshTokenResponse, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .refreshToken,
            responseType: RefreshTokenResponse.self
        ) { result in
            switch result {
            case .success(let response):
                // 更新token
                UserDefaults.standard.set(response.token, forKey: UserDefaultsKeys.userToken)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// 登出
    /// - Parameter completion: 完成回调
    func logout(completion: @escaping (Result<LogoutResponse, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .logout,
            responseType: LogoutResponse.self
        ) { result in
            // 无论成功失败都清除本地数据
            self.clearUserInfo()
            completion(result)
        }
    }
    
    // MARK: - 用户信息管理
    
    /// 保存用户信息
    /// - Parameter loginResponse: 登录响应
    private func saveUserInfo(_ loginResponse: LoginResponse) {
        UserDefaults.standard.set(loginResponse.token, forKey: UserDefaultsKeys.userToken)
        UserDefaults.standard.set(loginResponse.isFirstLogin, forKey: UserDefaultsKeys.isFirstLogin)
        
        if let userInfo = loginResponse.userInfo {
            if let userData = try? JSONEncoder().encode(userInfo) {
                UserDefaults.standard.set(userData, forKey: UserDefaultsKeys.userInfo)
            }
            UserDefaults.standard.set(userInfo.userType, forKey: UserDefaultsKeys.userType)
        }
    }
    
    /// 清除用户信息
    private func clearUserInfo() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userToken)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userInfo)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.isFirstLogin)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userType)
    }
    
    /// 获取当前用户Token
    /// - Returns: 用户Token
    func getCurrentToken() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.userToken)
    }
    
    /// 获取当前用户信息
    /// - Returns: 用户信息
    func getCurrentUserInfo() -> UserInfo? {
        guard let userData = UserDefaults.standard.data(forKey: UserDefaultsKeys.userInfo),
              let userInfo = try? JSONDecoder().decode(UserInfo.self, from: userData) else {
            return nil
        }
        return userInfo
    }
    
    /// 是否已登录
    /// - Returns: 是否已登录
    func isLoggedIn() -> Bool {
        return getCurrentToken() != nil
    }
    
    /// 是否首次登录
    /// - Returns: 是否首次登录
    func isFirstLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isFirstLogin)
    }
    
    /// 是否VIP用户
    /// - Returns: 是否VIP用户
    func isVIPUser() -> Bool {
        let userType = UserDefaults.standard.string(forKey: UserDefaultsKeys.userType) ?? "normal"
        return userType == "vip"
    }
}
