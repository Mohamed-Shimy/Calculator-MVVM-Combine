//
//  CurrencyAPI.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation

enum CurrencyAPI {
    
    case convert(_ amount: Double, from: String, to: String)
}

extension CurrencyAPI: TargetType {
    
    var baseURL: String {
        "https://neutrinoapi.net"
    }
    
    var path: String {
        switch self {
            case .convert: return "/convert"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .convert: return .post
        }
    }
    
    var headers: [String : String]? {
        ["Accept": "application/json",
         "api-key": "I15Wfb66poMfjxkn52B9yhYLXmDPmEQGobRiqYajfhmYS8i5",
         "user-id": "Currency120"]
        /*
         - very bad way to handle secretes
         */
    }
    
    var task: Task {
        switch self {
            case let .convert(amount, from, to):
                let parameters: [String: Any] = [
                    "from-value": amount,
                    "from-type": from,
                    "to-type": to
                ]
                return .withParameters(parameters, encoding: .httpBody)
        }
    }
}
