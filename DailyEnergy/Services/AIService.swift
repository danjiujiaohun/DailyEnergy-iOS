//
//  AIService.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2024/12/30.
//

import Foundation

/// AI服务
class AIService {
    /// 单例
    static let shared = AIService()
    
    private let networkManager = NetworkManager.shared
    
    private init() {}
    
    // MARK: - AI食物识别相关方法
    
    /// 上传图片进行食物识别
    /// - Parameters:
    ///   - imageData: 图片数据
    ///   - completion: 完成回调
    func recognizeFood(imageData: Data, completion: @escaping (Result<FoodRecognitionResponse, NetworkError>) -> Void) {
        // 先上传图片
        networkManager.uploadImage(imageData: imageData) { [weak self] result in
            switch result {
            case .success(let uploadResponse):
                // 使用上传后的图片URL进行识别
                self?.recognizeFood(imageUrl: uploadResponse.url, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// 通过图片URL进行食物识别
    /// - Parameters:
    ///   - imageUrl: 图片URL
    ///   - completion: 完成回调
    func recognizeFood(imageUrl: String, completion: @escaping (Result<FoodRecognitionResponse, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .recognizeFood(imageUrl: imageUrl),
            responseType: FoodRecognitionResponse.self,
            completion: completion
        )
    }
    
    /// 查询AI任务状态
    /// - Parameters:
    ///   - taskId: 任务ID
    ///   - completion: 完成回调
    func getTaskStatus(taskId: String, completion: @escaping (Result<AITaskStatusResponse, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .getTaskStatus(taskId: taskId),
            responseType: AITaskStatusResponse.self,
            completion: completion
        )
    }
    
    /// 轮询任务状态直到完成
    /// - Parameters:
    ///   - taskId: 任务ID
    ///   - maxAttempts: 最大尝试次数
    ///   - interval: 轮询间隔（秒）
    ///   - completion: 完成回调
    func pollTaskStatus(taskId: String, maxAttempts: Int = 30, interval: TimeInterval = 2.0, completion: @escaping (Result<AITaskStatusResponse, NetworkError>) -> Void) {
        var attempts = 0
        
        func poll() {
            attempts += 1
            
            getTaskStatus(taskId: taskId) { result in
                switch result {
                case .success(let response):
                    if response.status == "completed" || response.status == "failed" {
                        // 任务完成或失败，返回结果
                        completion(.success(response))
                    } else if attempts >= maxAttempts {
                        // 达到最大尝试次数，返回超时错误
                        completion(.failure(.timeout))
                    } else {
                        // 继续轮询
                        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                            poll()
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        poll()
    }
    
    // MARK: - AI食物热量查询相关方法
    
    /// 查询食物热量信息
    /// - Parameters:
    ///   - foodName: 食物名称
    ///   - description: 食物描述（可选）
    ///   - completion: 完成回调
    func getFoodCalories(foodName: String, description: String? = nil, completion: @escaping (Result<FoodCaloriesResponse, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .getFoodCalories(foodName: foodName, description: description),
            responseType: FoodCaloriesResponse.self,
            completion: completion
        )
    }
    
    // MARK: - 便捷方法
    
    /// 识别食物并获取热量信息（一站式服务）
    /// - Parameters:
    ///   - imageData: 图片数据
    ///   - completion: 完成回调，返回识别结果和热量信息
    func recognizeFoodAndGetCalories(imageData: Data, completion: @escaping (Result<(recognition: FoodRecognitionResult, calories: [FoodCaloriesResponse]), NetworkError>) -> Void) {
        
        recognizeFood(imageData: imageData) { [weak self] result in
            switch result {
            case .success(let recognitionResponse):
                if recognitionResponse.success {
                    // 轮询任务状态
                    self?.pollTaskStatus(taskId: recognitionResponse.taskId) { statusResult in
                        switch statusResult {
                        case .success(let statusResponse):
                            if statusResponse.status == "completed", let recognitionResult = statusResponse.result {
                                // 识别成功，获取每个食物的热量信息
                                self?.getCaloriesForRecognizedFoods(recognitionResult.foods) { caloriesResult in
                                    switch caloriesResult {
                                    case .success(let caloriesResponses):
                                        completion(.success((recognition: recognitionResult, calories: caloriesResponses)))
                                    case .failure(let error):
                                        completion(.failure(error))
                                    }
                                }
                            } else {
                                completion(.failure(.serverError("识别失败: \(statusResponse.errorMessage ?? "未知错误")")))
                            }
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } else {
                    completion(.failure(.serverError("识别请求失败")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// 为识别到的食物获取热量信息
    /// - Parameters:
    ///   - foods: 识别到的食物列表
    ///   - completion: 完成回调
    private func getCaloriesForRecognizedFoods(_ foods: [RecognizedFood], completion: @escaping (Result<[FoodCaloriesResponse], NetworkError>) -> Void) {
        let group = DispatchGroup()
        var caloriesResponses: [FoodCaloriesResponse] = []
        var hasError: NetworkError?
        
        for food in foods {
            group.enter()
            getFoodCalories(foodName: food.name, description: nil) { result in
                defer { group.leave() }
                
                switch result {
                case .success(let caloriesResponse):
                    caloriesResponses.append(caloriesResponse)
                case .failure(let error):
                    hasError = error
                }
            }
        }
        
        group.notify(queue: .main) {
            if let error = hasError {
                completion(.failure(error))
            } else {
                completion(.success(caloriesResponses))
            }
        }
    }
    
    /// 智能食物建议（基于用户历史和目标）
    /// - Parameters:
    ///   - mealType: 餐次类型
    ///   - targetCalories: 目标热量
    ///   - completion: 完成回调
    func getFoodSuggestions(mealType: String, targetCalories: Double, completion: @escaping (Result<[FoodInfo], NetworkError>) -> Void) {
        // 这里可以调用AI接口获取智能推荐
        // 暂时返回空数组，实际实现需要根据后端API
        completion(.success([]))
    }
    
    /// 智能运动建议（基于用户目标和当前热量摄入）
    /// - Parameters:
    ///   - currentCalories: 当前热量摄入
    ///   - targetCalories: 目标热量
    ///   - completion: 完成回调
    func getExerciseSuggestions(currentCalories: Double, targetCalories: Double, completion: @escaping (Result<[ExerciseInfo], NetworkError>) -> Void) {
        // 这里可以调用AI接口获取智能推荐
        // 暂时返回空数组，实际实现需要根据后端API
        completion(.success([]))
    }
}
