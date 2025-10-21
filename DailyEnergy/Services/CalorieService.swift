//
//  CalorieService.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2024/12/30.
//

import Foundation

/// 热量服务
class CalorieService {
    /// 单例
    static let shared = CalorieService()
    
    private let networkManager = NetworkManager.shared
    
    private init() {}
    
    // MARK: - 热量记录相关方法
    
    /// 添加食物摄入记录
    /// - Parameters:
    ///   - foodIntake: 食物摄入信息
    ///   - completion: 完成回调
    func addFoodIntake(_ foodIntake: FoodIntakeRequest, completion: @escaping (Result<CalorieRecord, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .addFoodIntake(foodIntake),
            responseType: CalorieRecord.self,
            completion: completion
        )
    }
    
    /// 添加运动记录
    /// - Parameters:
    ///   - exerciseRecord: 运动记录信息
    ///   - completion: 完成回调
    func addExercise(_ exerciseRecord: ExerciseRecordRequest, completion: @escaping (Result<CalorieRecord, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .addExerciseRecord(exerciseRecord),
            responseType: CalorieRecord.self,
            completion: completion
        )
    }
    
    /// 获取今日热量概览
    /// - Parameter completion: 完成回调
    func getTodaySummary(completion: @escaping (Result<TodaySummary, NetworkError>) -> Void) {
        networkManager.getTodaySummary(completion: completion)
    }
    
    /// 获取热量记录历史
    /// - Parameters:
    ///   - date: 日期
    ///   - completion: 完成回调
    func getCalorieHistory(date: String, completion: @escaping (Result<CalorieHistory, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .getCalorieHistory(startDate: date, endDate: date),
            responseType: CalorieHistory.self,
            completion: completion
        )
    }
    
    /// 获取热量记录历史（日期范围）
    /// - Parameters:
    ///   - startDate: 开始日期
    ///   - endDate: 结束日期
    ///   - completion: 完成回调
    func getCalorieHistoryRange(startDate: String, endDate: String, completion: @escaping (Result<[CalorieHistory], NetworkError>) -> Void) {
        networkManager.requestArray(
            endpoint: .getCalorieHistoryRange(startDate: startDate, endDate: endDate),
            responseType: CalorieHistory.self,
            completion: completion
        )
    }
    
    /// 更新热量记录
    /// - Parameters:
    ///   - recordId: 记录ID
    ///   - request: 热量记录请求信息
    ///   - completion: 完成回调
    func updateCalorieRecord(recordId: Int, request: CalorieRecordRequest, completion: @escaping (Result<CalorieRecord, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .updateCalorieRecord(recordId: recordId, request: request),
            responseType: CalorieRecord.self,
            completion: completion
        )
    }
    
    /// 删除热量记录
    /// - Parameters:
    ///   - recordId: 记录ID
    ///   - completion: 完成回调
    func deleteCalorieRecord(recordId: Int, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .deleteCalorieRecord(recordId: recordId),
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
    
    // MARK: - 食物信息相关方法
    
    /// 搜索食物信息
    /// - Parameters:
    ///   - keyword: 搜索关键词
    ///   - completion: 完成回调
    func searchFood(keyword: String, completion: @escaping (Result<[FoodInfo], NetworkError>) -> Void) {
        networkManager.requestArray(
            endpoint: .searchFood(keyword: keyword),
            responseType: FoodInfo.self,
            completion: completion
        )
    }
    
    /// 获取食物详情
    /// - Parameters:
    ///   - foodId: 食物ID
    ///   - completion: 完成回调
    func getFoodDetail(foodId: Int, completion: @escaping (Result<FoodInfo, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .getFoodDetail(foodId: foodId),
            responseType: FoodInfo.self,
            completion: completion
        )
    }
    
    // MARK: - 运动信息相关方法
    
    /// 搜索运动信息
    /// - Parameters:
    ///   - keyword: 搜索关键词
    ///   - completion: 完成回调
    func searchExercise(keyword: String, completion: @escaping (Result<[ExerciseInfo], NetworkError>) -> Void) {
        networkManager.requestArray(
            endpoint: .searchExercise(keyword: keyword),
            responseType: ExerciseInfo.self,
            completion: completion
        )
    }
    
    /// 获取运动详情
    /// - Parameters:
    ///   - exerciseId: 运动ID
    ///   - completion: 完成回调
    func getExerciseDetail(exerciseId: Int, completion: @escaping (Result<ExerciseInfo, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .getExerciseDetail(exerciseId: exerciseId),
            responseType: ExerciseInfo.self,
            completion: completion
        )
    }
    
    // MARK: - 统计相关方法
    
    /// 获取热量趋势
    /// - Parameters:
    ///   - days: 天数
    ///   - completion: 完成回调
    func getCalorieTrend(days: Int, completion: @escaping (Result<CalorieTrendResponse, NetworkError>) -> Void) {
        let endDate = DateFormatter.yyyyMMdd.string(from: Date())
        let startDate = DateFormatter.yyyyMMdd.string(from: Calendar.current.date(byAdding: .day, value: -days, to: Date()) ?? Date())
        
        networkManager.request(
            endpoint: .getCalorieTrend(period: "days", startDate: startDate, endDate: endDate),
            responseType: CalorieTrendResponse.self,
            completion: completion
        )
    }
    
    /// 获取体重趋势
    /// - Parameters:
    ///   - period: 时间周期
    ///   - startDate: 开始日期（可选）
    ///   - endDate: 结束日期（可选）
    ///   - completion: 完成回调
    func getWeightTrend(period: String, startDate: String? = nil, endDate: String? = nil, completion: @escaping (Result<WeightTrendResponse, NetworkError>) -> Void) {
        networkManager.request(
            endpoint: .getWeightTrend(period: period, startDate: startDate, endDate: endDate),
            responseType: WeightTrendResponse.self,
            completion: completion
        )
    }
    
    /// 获取周统计
    /// - Parameters:
    ///   - startDate: 开始日期
    ///   - completion: 完成回调
    func getWeeklyStats(startDate: String, completion: @escaping (Result<[CalorieHistory], NetworkError>) -> Void) {
        networkManager.requestArray(
            endpoint: .getWeeklyStats(startDate: startDate),
            responseType: CalorieHistory.self,
            completion: completion
        )
    }
    
    /// 获取月统计
    /// - Parameters:
    ///   - month: 月份（格式：YYYY-MM）
    ///   - completion: 完成回调
    func getMonthlyStats(month: String, completion: @escaping (Result<[CalorieHistory], NetworkError>) -> Void) {
        networkManager.requestArray(
            endpoint: .getMonthlyStats(month: month),
            responseType: CalorieHistory.self,
            completion: completion
        )
    }
    
    // MARK: - 便捷方法
    
    /// 快速添加食物（通过名称和重量）
    /// - Parameters:
    ///   - foodName: 食物名称
    ///   - weight: 重量（克）
    ///   - mealType: 餐次类型
    ///   - completion: 完成回调
    func quickAddFood(foodName: String, weight: Double, mealType: String, completion: @escaping (Result<CalorieRecord, NetworkError>) -> Void) {
        let foodIntake = FoodIntakeRequest(
            foodName: foodName,
            weight: weight,
            calories: 0.0,
            mealType: mealType,
            recordTime: DateFormatter.yyyyMMdd.string(from: Date())
        )
        addFoodIntake(foodIntake, completion: completion)
    }
    
    /// 快速添加运动（通过名称和时长）
    /// - Parameters:
    ///   - exerciseName: 运动名称
    ///   - duration: 时长（分钟）
    ///   - completion: 完成回调
    func quickAddExercise(exerciseName: String, duration: Int, completion: @escaping (Result<CalorieRecord, NetworkError>) -> Void) {
        let exerciseRecord = ExerciseRecordRequest(
            exerciseName: exerciseName,
            duration: duration,
            caloriesBurned: 0.0,
            recordDate: DateFormatter.yyyyMMdd.string(from: Date())
        )
        addExercise(exerciseRecord, completion: completion)
    }
}

// MARK: - DateFormatter Extension

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
