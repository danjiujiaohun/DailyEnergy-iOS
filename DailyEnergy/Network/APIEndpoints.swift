//
//  APIEndpoints.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2024/12/30.
//

import Foundation
import Alamofire

/// API端点枚举
enum APIEndpoint {
    // MARK: - 认证相关
    case sendCode(phone: String)
    case login(phone: String, code: String, loginType: String)
    case wechatLogin(code: String)
    case appleLogin(identityToken: String)
    case refreshToken
    case logout
    
    // MARK: - 用户相关
    case getUserProfile
    case updateUserProfile(UserUpdateRequest)
    case uploadAvatar(imageData: Data)
    case deleteAccount
    
    // MARK: - 热量记录相关
    case addFoodIntake(FoodIntakeRequest)
    case getTodaySummary
    case getCalorieHistory(startDate: String, endDate: String)
    case getCalorieHistoryRange(startDate: String, endDate: String)
    case updateCalorieRecord(recordId: Int, request: CalorieRecordRequest)
    case deleteCalorieRecord(recordId: Int)
    
    // MARK: - 食物信息相关
    case searchFood(keyword: String)
    case getFoodDetail(foodId: Int)
    
    // MARK: - 运动相关
    case searchExercise(keyword: String)
    case getExerciseDetail(exerciseId: Int)
    case addExerciseRecord(ExerciseRecordRequest)
    case getExerciseRecords(startDate: String?, endDate: String?, page: Int, size: Int)
    case updateExerciseRecord(recordId: Int, request: ExerciseRecordRequest)
    case deleteExerciseRecord(recordId: Int)
    case getPopularExercises
    case getExerciseStatistics(period: String, startDate: String?, endDate: String?)
    
    // MARK: - 统计相关
    case getCalorieTrend(period: String, startDate: String?, endDate: String?)
    case getStatisticsOverview
    case getNutritionAnalysis(period: String, startDate: String?, endDate: String?)
    case getWeightTrend(period: String, startDate: String?, endDate: String?)
    case getStatisticsExercise(period: String, startDate: String?, endDate: String?)
    case getGoalAchievement(period: String?)
    case getFoodPreference(period: String?)
    case getHealthScore(date: String?)
    case getWeeklyReport(weekStart: String?)
    case getMonthlyReport(month: String?)
    case getLeaderboard(type: String, limit: Int)
    case exportStatistics(type: String, format: String, startDate: String?, endDate: String?)
    case getWeeklyStats(startDate: String)
    case getMonthlyStats(month: String)
    
    // MARK: - AI识别相关
    case uploadImage(imageData: Data)
    case recognizeFood(imageUrl: String)
    case getTaskStatus(taskId: String)
    case getFoodCalories(foodName: String, description: String?)
    
    // MARK: - 用户目标相关
    case getUserGoal
    case updateUserGoal(goal: UserGoal)
    
    // MARK: - 体重记录相关
    case getWeightRecords(startDate: String, endDate: String)
    case addWeightRecord(weight: Double, date: String)
    case updateWeightRecord(recordId: Int, weight: Double)
    case deleteWeightRecord(recordId: Int)
    
    /// 请求路径
    var path: String {
        switch self {
        case .sendCode: return "/auth/send-code"
        case .login: return "/auth/login"
        case .wechatLogin: return "/auth/login/wechat"
        case .appleLogin: return "/auth/login/apple"
        case .refreshToken: return "/auth/refresh"
        case .logout: return "/auth/logout"
        case .getUserProfile: return "/user/profile"
        case .updateUserProfile: return "/user/profile"
        case .uploadAvatar: return "/file/upload/avatar"
        case .deleteAccount: return "/user/account"
        case .addFoodIntake: return "/calorie/record"
        case .getTodaySummary: return "/calorie/daily"
        case .getCalorieHistory: return "/calorie/records"
        case .getCalorieHistoryRange: return "/calorie/trend"
        case .updateCalorieRecord(let recordId, _): return "/calorie/record/\(recordId)"
        case .deleteCalorieRecord(let recordId): return "/calorie/record/\(recordId)"
        case .searchFood: return "/calorie/food/search"
        case .getFoodDetail(let foodId): return "/calorie/food/\(foodId)"
        case .searchExercise: return "/exercise/search"
        case .getExerciseDetail(let exerciseId): return "/exercise/\(exerciseId)"
        case .addExerciseRecord: return "/exercise/record"
        case .getExerciseRecords: return "/exercise/records"
        case .updateExerciseRecord(let recordId, _): return "/exercise/record/\(recordId)"
        case .deleteExerciseRecord(let recordId): return "/exercise/record/\(recordId)"
        case .getPopularExercises: return "/exercise/popular"
        case .getExerciseStatistics: return "/exercise/statistics"
        case .getCalorieTrend: return "/statistics/calorie-trend"
        case .getStatisticsOverview: return "/statistics/overview"
        case .getNutritionAnalysis: return "/statistics/nutrition"
        case .getWeightTrend: return "/statistics/weight-trend"
        case .getStatisticsExercise: return "/statistics/exercise"
        case .getGoalAchievement: return "/statistics/goal-achievement"
        case .getFoodPreference: return "/statistics/food-preference"
        case .getHealthScore: return "/statistics/health-score"
        case .getWeeklyReport: return "/statistics/weekly-report"
        case .getMonthlyReport: return "/statistics/monthly-report"
        case .getLeaderboard: return "/statistics/leaderboard"
        case .exportStatistics: return "/statistics/export"
        case .getWeeklyStats: return "/statistics/weekly-report"
        case .getMonthlyStats: return "/statistics/monthly-report"
        case .uploadImage: return "/file/upload/image"
        case .recognizeFood: return "/ai/food-recognition"
        case .getTaskStatus(let taskId): return "/ai/task/\(taskId)"
        case .getFoodCalories: return "/ai/food-calories"
        case .getUserGoal: return "/user/goal"
        case .updateUserGoal: return "/user/goal"
        case .getWeightRecords: return "/user/weight-records"
        case .addWeightRecord: return "/user/weight-records"
        case .updateWeightRecord(let recordId, _): return "/user/weight-records/\(recordId)"
        case .deleteWeightRecord(let recordId): return "/user/weight-records/\(recordId)"
        }
    }
    
    /// HTTP方法
    var method: HTTPMethod {
        switch self {
        case .sendCode, .login, .wechatLogin, .appleLogin, .addFoodIntake, .addExerciseRecord,
             .uploadImage, .recognizeFood, .getFoodCalories, .uploadAvatar, .addWeightRecord, .logout:
            return .post
        case .updateUserProfile, .updateUserGoal, .updateWeightRecord, .updateCalorieRecord, .updateExerciseRecord:
            return .put
        case .deleteAccount, .deleteWeightRecord, .deleteCalorieRecord, .deleteExerciseRecord:
            return .delete
        default:
            return .get
        }
    }
    
    /// 请求参数
    var parameters: [String: Any]? {
        switch self {
        case .sendCode(let phone):
            return ["phone": phone]
        case .login(let phone, let code, let loginType):
            return ["phone": phone, "code": code, "loginType": loginType]
        case .wechatLogin(let code):
            return ["code": code]
        case .appleLogin(let identityToken):
            return ["identityToken": identityToken]
        case .updateUserProfile(let request):
            return request.toJSON()
        case .addFoodIntake(let request):
            return request.toJSON()
        case .getCalorieHistory(let startDate, let endDate):
            return ["startDate": startDate, "endDate": endDate]
        case .getCalorieHistoryRange(let startDate, let endDate):
            return ["startDate": startDate, "endDate": endDate]
        case .addExerciseRecord(let request):
            return request.toJSON()
        case .getExerciseRecords(let startDate, let endDate, let page, let size):
            var params: [String: Any] = ["page": page, "size": size]
            if let start = startDate {
                params["startDate"] = start
            }
            if let end = endDate {
                params["endDate"] = end
            }
            return params
        case .updateExerciseRecord(_, let request):
            return request.toJSON()
        case .getExerciseStatistics(let period, let startDate, let endDate):
            var params: [String: Any] = ["period": period]
            if let start = startDate {
                params["startDate"] = start
            }
            if let end = endDate {
                params["endDate"] = end
            }
            return params
        case .recognizeFood(let imageUrl):
            return ["imageUrl": imageUrl]
        case .getFoodCalories(let foodName, let description):
            var params: [String: Any] = ["foodName": foodName]
            if let desc = description {
                params["description"] = desc
            }
            return params
        case .getCalorieTrend(let period, let startDate, let endDate):
            var params: [String: Any] = ["period": period]
            if let start = startDate {
                params["startDate"] = start
            }
            if let end = endDate {
                params["endDate"] = end
            }
            return params
        case .getNutritionAnalysis(let period, let startDate, let endDate):
            var params: [String: Any] = ["period": period]
            if let start = startDate {
                params["startDate"] = start
            }
            if let end = endDate {
                params["endDate"] = end
            }
            return params
        case .getWeightTrend(let period, let startDate, let endDate):
            var params: [String: Any] = ["period": period]
            if let start = startDate {
                params["startDate"] = start
            }
            if let end = endDate {
                params["endDate"] = end
            }
            return params
        case .getStatisticsExercise(let period, let startDate, let endDate):
            var params: [String: Any] = ["period": period]
            if let start = startDate {
                params["startDate"] = start
            }
            if let end = endDate {
                params["endDate"] = end
            }
            return params
        case .getGoalAchievement(let period):
            var params: [String: Any] = [:]
            if let p = period {
                params["period"] = p
            }
            return params.isEmpty ? nil : params
        case .getFoodPreference(let period):
            var params: [String: Any] = [:]
            if let p = period {
                params["period"] = p
            }
            return params.isEmpty ? nil : params
        case .getHealthScore(let date):
            var params: [String: Any] = [:]
            if let d = date {
                params["date"] = d
            }
            return params.isEmpty ? nil : params
        case .getWeeklyReport(let weekStart):
            var params: [String: Any] = [:]
            if let ws = weekStart {
                params["weekStart"] = ws
            }
            return params.isEmpty ? nil : params
        case .getMonthlyReport(let month):
            var params: [String: Any] = [:]
            if let m = month {
                params["month"] = m
            }
            return params.isEmpty ? nil : params
        case .getLeaderboard(let type, let limit):
            return ["type": type, "limit": limit]
        case .exportStatistics(let type, let format, let startDate, let endDate):
            var params: [String: Any] = ["type": type, "format": format]
            if let start = startDate {
                params["startDate"] = start
            }
            if let end = endDate {
                params["endDate"] = end
            }
            return params
        case .updateUserGoal(let goal):
            return goal.toJSON()
        case .getWeightRecords(let startDate, let endDate):
            return ["startDate": startDate, "endDate": endDate]
        case .addWeightRecord(let weight, let date):
            return ["weight": weight, "recordDate": date]
        case .updateWeightRecord(_, let weight):
            return ["weight": weight]

        case .updateCalorieRecord(_, let request):
            return request.toJSON()
        case .searchFood(let keyword):
            return ["keyword": keyword]
        case .searchExercise(let keyword):
            return ["keyword": keyword]
        case .getWeeklyStats(let startDate):
            return ["startDate": startDate]
        case .getMonthlyStats(let month):
            return ["month": month]
        default:
            return nil
        }
    }
    
    /// 是否需要认证
    var needsAuth: Bool {
        switch self {
        case .sendCode, .login, .wechatLogin, .appleLogin:
            return false
        default:
            return true
        }
    }
}
