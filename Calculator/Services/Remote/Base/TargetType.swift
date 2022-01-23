//
//  TargetType.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation

protocol TargetType {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: [String: String]? { get }
}

extension TargetType {
    
    var headers: [String: String]? {
        [:]
    }
}

// MARK: - Build URLRequest

extension TargetType {
    
    func buildURLRequest() -> URLRequest {
        var components = URLComponents(string: baseURL)!
        var bodyData: Data? = nil
        components.path = path
        
        if case let .withParameters(parameters, encoding) = task {
            switch encoding {
                case .httpBody:
                    bodyData = HttpBodyEncoding(parameters).bodyData
            }
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = bodyData
        
        return request
    }
}
