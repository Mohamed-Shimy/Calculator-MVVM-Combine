//
//  NetworkError.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation

struct NetworkError: LocalizedError, Identifiable {
    
    // MARK: - Properties
    
    public let id = UUID()
    let code: Int
    let message: String
    
    public var errorDescription: String? { message }
    
    // MARK: - init
    
    init(_ code: Int, message: String) {
        self.code = code
        self.message = message
    }
    
    init?(code: Int) {
        switch code {
            case 200...299: return nil
            case 300...308: message = "Redirection"
            case 400: message = "Bad Request"
            case 401: message = "Unauthorized"
            case 403: message = "Forbidden"
            case 404: message = "Not Found"
            case 429: message = "You have hit your requests limit"
            case 500...599: message = "Internal Server Error"
            default: message = "Unkown error"
        }
        self.code = code
    }
}

extension NetworkError {
    
    static let unkown = NetworkError(code: 0)!
}
