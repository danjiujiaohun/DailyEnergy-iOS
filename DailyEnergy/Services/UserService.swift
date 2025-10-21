//
//  UserService.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2024/12/30.
//

import Foundation

/// 用户服务
class UserService {
    /// 单例
    static let shared = UserService()
    
    private let networkManager = NetworkManager.shared
    
    private init() {}
    
    // MARK: - 用户信息相关方法
    
    /// 获取用户信息
    /// - Parameter completion: 完成回调
    func getUserInfo(completion: @escaping (Result<UserInfo, NetworkError>) -> Void) {
        networkManager.getUserInfo(completion: completion)
    }
    
    /// 更新用户信息
    /// - Parameters:
    ///   - userInfo: 用户信息
    ///   - completion: 完成回调
    func updateUserInfo(_ userInfo: UserUpdateRequest, completion: @escaping (Result<UserInfo, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .updateUserProfile(userInfo),
            responseType: UserInfo.self
        ) { result in
            switch result {
            case .success(let updatedUserInfo):
                // 更新本地缓存
                self.saveUserInfoToLocal(updatedUserInfo)
                completion(.success(updatedUserInfo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// 获取用户档案
    /// - Parameter completion: 完成回调
    func getUserProfile(completion: @escaping (Result<UserProfile, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .getUserProfile,
            responseType: UserProfile.self,
            completion: completion
        )
    }
    
    /// 更新用户档案
    /// - Parameters:
    ///   - profile: 用户档案
    ///   - completion: 完成回调
    func updateUserProfile(_ profile: UserProfile, completion: @escaping (Result<UserProfile, NetworkError>) -> Void) {
        // 将UserProfile转换为UserUpdateRequest
        let updateRequest = UserUpdateRequest(
            nickname: profile.nickname.isEmpty ? nil : profile.nickname,
            gender: profile.gender == 0 ? nil : profile.gender,
            age: profile.age == 0 ? nil : profile.age,
            height: profile.height == 0.0 ? nil : profile.height,
            weight: profile.weight == 0.0 ? nil : profile.weight,
            targetWeight: profile.targetWeight == 0.0 ? nil : profile.targetWeight,
            activityLevel: profile.activityLevel.isEmpty ? nil : profile.activityLevel
        )
        
        networkManager.request(
            endpoint: .updateUserProfile(updateRequest),
            responseType: UserProfile.self,
            completion: completion
        )
    }
    
    /// 上传头像
    /// - Parameters:
    ///   - imageData: 图片数据
    ///   - completion: 完成回调
    func uploadAvatar(imageData: Data, completion: @escaping (Result<UploadResponse, NetworkError>) -> Void) {
        networkManager.uploadAvatar(imageData: imageData, completion: completion)
    }
    
    /// 删除用户账户
    /// - Parameter completion: 完成回调
    func deleteAccount(completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .deleteAccount,
            responseType: DeleteAccountResponse.self
        ) { result in
            switch result {
            case .success(let response):
                if response.success {
                    // 清除本地数据
                    self.clearLocalData()
                }
                completion(.success(response.success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - 用户目标相关方法
    
    /// 获取用户目标
    /// - Parameter completion: 完成回调
    func getUserGoal(completion: @escaping (Result<UserGoal, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .getUserGoal,
            responseType: UserGoal.self,
            completion: completion
        )
    }
    
    /// 更新用户目标
    /// - Parameters:
    ///   - goal: 用户目标
    ///   - completion: 完成回调
    func updateUserGoal(_ goal: UserGoal, completion: @escaping (Result<UserGoal, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .updateUserGoal(goal: goal),
            responseType: UserGoal.self,
            completion: completion
        )
    }
    
    // MARK: - 体重记录相关方法
    
    /// 获取体重记录
    /// - Parameters:
    ///   - startDate: 开始日期
    ///   - endDate: 结束日期
    ///   - completion: 完成回调
    func getWeightRecords(startDate: String, endDate: String, completion: @escaping (Result<[WeightRecord], NetworkError>) -> Void) {
        networkManager.requestArray(
            endpoint: .getWeightRecords(startDate: startDate, endDate: endDate),
            responseType: WeightRecord.self,
            completion: completion
        )
    }
    
    /// 添加体重记录
    /// - Parameters:
    ///   - weight: 体重
    ///   - date: 日期
    ///   - completion: 完成回调
    func addWeightRecord(weight: Double, date: String, completion: @escaping (Result<WeightRecord, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .addWeightRecord(weight: weight, date: date),
            responseType: WeightRecord.self,
            completion: completion
        )
    }
    
    /// 更新体重记录
    /// - Parameters:
    ///   - recordId: 记录ID
    ///   - weight: 体重
    ///   - completion: 完成回调
    func updateWeightRecord(recordId: Int, weight: Double, completion: @escaping (Result<WeightRecord, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .updateWeightRecord(recordId: recordId, weight: weight),
            responseType: WeightRecord.self,
            completion: completion
        )
    }
    
    /// 删除体重记录
    /// - Parameters:
    ///   - recordId: 记录ID
    ///   - completion: 完成回调
    func deleteWeightRecord(recordId: Int, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .deleteWeightRecord(recordId: recordId),
            responseType: APIResponse<DeleteAccountResponse>.self
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data?.success ?? false))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - 本地数据管理
    
    /// 保存用户信息到本地
    /// - Parameter userInfo: 用户信息
    private func saveUserInfoToLocal(_ userInfo: UserInfo) {
        if let userData = try? JSONEncoder().encode(userInfo) {
            UserDefaults.standard.set(userData, forKey: UserDefaultsKeys.userInfo)
        }
        UserDefaults.standard.set(userInfo.userType, forKey: UserDefaultsKeys.userType)
    }
    
    /// 清除本地数据
    private func clearLocalData() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userToken)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userInfo)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.isFirstLogin)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userType)
    }
    
    /// 获取本地缓存的用户信息
    /// - Returns: 用户信息
    func getCachedUserInfo() -> UserInfo? {
        guard let userData = UserDefaults.standard.data(forKey: UserDefaultsKeys.userInfo),
              let userInfo = try? JSONDecoder().decode(UserInfo.self, from: userData) else {
            return nil
        }
        return userInfo
    }
}
