//
//  NetworkManager.swift
//  DailyEnergy
//
//  Created by 梁江斌 on 2024/12/30.
//

import Foundation
import Alamofire
import HandyJSON

/// 网络管理器
class NetworkManager {
    /// 单例
    static let shared = NetworkManager()
    
    private let session: Session
    private let baseURL = APIConfig.baseURL
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = APIConfig.timeout
        configuration.timeoutIntervalForResource = APIConfig.timeout
        
        session = Session(configuration: configuration)
    }
    
    // MARK: - 通用请求方法
    func request<T: HandyJSON>(
        endpoint: APIEndpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let url = baseURL + endpoint.path
        
        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        // 添加认证token
        if endpoint.needsAuth, let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.userToken) {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        session.request(
            url,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseData { response in
            self.handleResponse(response: response, responseType: responseType, completion: completion)
        }
    }
    
    // MARK: - 数组请求方法
    func requestArray<T: HandyJSON>(
        endpoint: APIEndpoint,
        responseType: T.Type,
        completion: @escaping (Result<[T], NetworkError>) -> Void
    ) {
        let url = baseURL + endpoint.path
        
        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        // 添加认证token
        if endpoint.needsAuth, let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.userToken) {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        session.request(
            url,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseData { response in
            self.handleArrayResponse(response: response, responseType: responseType, completion: completion)
        }
    }
    
    // MARK: - 上传文件
    func uploadFile<T: HandyJSON>(
        endpoint: APIEndpoint,
        fileData: Data,
        fileName: String,
        mimeType: String,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let url = baseURL + endpoint.path
        
        var headers: HTTPHeaders = [:]
        if endpoint.needsAuth, let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.userToken) {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        session.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(fileData, withName: "file", fileName: fileName, mimeType: mimeType)
                
                // 添加其他参数
                if let parameters = endpoint.parameters {
                    for (key, value) in parameters {
                        if let stringValue = "\(value)".data(using: .utf8) {
                            multipartFormData.append(stringValue, withName: key)
                        }
                    }
                }
            },
            to: url,
            headers: headers
        ).responseData { response in
            self.handleResponse(response: response, responseType: responseType, completion: completion)
        }
    }
    
    // MARK: - 响应处理
    private func handleResponse<T: HandyJSON>(
        response: AFDataResponse<Data>,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        switch response.result {
        case .success(let data):
            do {
                if let jsonString = String(data: data, encoding: .utf8),
                   let apiResponse = APIResponse<T>.deserialize(from: jsonString) {
                    
                    if apiResponse.isSuccess, let responseData = apiResponse.data {
                        completion(.success(responseData))
                    } else {
                        let error = NetworkError.serverError(apiResponse.message)
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(.decodingError))
                }
            }
        case .failure(let error):
            let networkError = self.mapAlamofireError(error)
            completion(.failure(networkError))
        }
    }
    
    // MARK: - 数组响应处理
    private func handleArrayResponse<T: HandyJSON>(
        response: AFDataResponse<Data>,
        responseType: T.Type,
        completion: @escaping (Result<[T], NetworkError>) -> Void
    ) {
        switch response.result {
        case .success(let data):
            do {
                if let jsonString = String(data: data, encoding: .utf8) {
                    // 尝试直接解析为数组
                    if let arrayData = [T].deserialize(from: jsonString) {
                        let nonNilArray = arrayData.compactMap { $0 }
                        completion(.success(nonNilArray))
                    } else {
                        completion(.failure(.decodingError))
                    }
                } else {
                    completion(.failure(.decodingError))
                }
            }
        case .failure(let error):
            let networkError = self.mapAlamofireError(error)
            completion(.failure(networkError))
        }
    }
    
    // MARK: - 错误映射
    private func mapAlamofireError(_ error: AFError) -> NetworkError {
        switch error {
        case .invalidURL:
            return .invalidURL
        case .responseValidationFailed:
            return .decodingError
        case .sessionTaskFailed(let sessionError):
            if let urlError = sessionError as? URLError {
                switch urlError.code {
                case .timedOut:
                    return .timeout
                case .notConnectedToInternet, .networkConnectionLost:
                    return .networkError(urlError)
                default:
                    return .networkError(urlError)
                }
            }
            return .networkError(sessionError)
        default:
            return .unknown
        }
    }
}

// MARK: - 便捷方法
extension NetworkManager {
    /// 发送验证码
    func sendCode(phone: String, completion: @escaping (Result<SendCodeResponse, NetworkError>) -> Void) {
        request(endpoint: .sendCode(phone: phone), responseType: SendCodeResponse.self, completion: completion)
    }
    
    /// 用户登录
    func login(phone: String, code: String, loginType: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        request(endpoint: .login(phone: phone, code: code, loginType: loginType), responseType: LoginResponse.self, completion: completion)
    }
    
    /// 获取用户信息
    func getUserInfo(completion: @escaping (Result<UserInfo, NetworkError>) -> Void) {
        request(endpoint: .getUserProfile, responseType: UserInfo.self, completion: completion)
    }
    
    /// 获取今日热量概览
    func getTodaySummary(completion: @escaping (Result<TodaySummary, NetworkError>) -> Void) {
        request(endpoint: .getTodaySummary, responseType: TodaySummary.self, completion: completion)
    }
    
    /// 上传头像
    func uploadAvatar(imageData: Data, completion: @escaping (Result<UploadResponse, NetworkError>) -> Void) {
        uploadFile(
            endpoint: .uploadAvatar(imageData: imageData),
            fileData: imageData,
            fileName: "avatar.jpg",
            mimeType: "image/jpeg",
            responseType: UploadResponse.self,
            completion: completion
        )
    }
    
    /// 上传图片
    func uploadImage(imageData: Data, completion: @escaping (Result<UploadResponse, NetworkError>) -> Void) {
        uploadFile(
            endpoint: .uploadImage(imageData: imageData),
            fileData: imageData,
            fileName: "image.jpg",
            mimeType: "image/jpeg",
            responseType: UploadResponse.self,
            completion: completion
        )
    }
}
